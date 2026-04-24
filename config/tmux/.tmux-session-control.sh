#!/usr/bin/env bash
# Interactive tmux session picker: join, create, or close sessions.
set -euo pipefail

# ANSI colours for menus (disabled if NO_COLOR is set or stdout is not a TTY).
menu_colors_init() {
	if [[ -n "${NO_COLOR:-}" ]] || ! [[ -t 1 ]]; then
		C_OFF='' C_NUM='' C_SESS='' C_NEW='' C_CLOSE='' C_QUIT='' C_BACK='' C_ERR=''
		return 0
	fi
	C_OFF=$'\033[0m'
	C_NUM=$'\033[1;36m'   # choice index
	C_SESS=$'\033[0;32m' # session names
	C_NEW=$'\033[0;33m'  # create
	C_CLOSE=$'\033[0;31m' # close / destructive
	C_QUIT=$'\033[2m'    # quit / back
	C_BACK=$'\033[2m'
	C_ERR=$'\033[0;31m'
}

# Print main menu lines; session strings are uncoloured in data passed to tmux later.
render_main_menu_lines() {
	local -n _s="$1"
	local n=${#_s[@]} i c=1
	for ((i = 0; i < n; i++)); do
		printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_SESS}" "${_s[i]}" "${C_OFF}"
		((++c))
	done
	printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_NEW}" "Create new session" "${C_OFF}"
	((++c))
	printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_CLOSE}" "Close a session" "${C_OFF}"
	((++c))
	printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_QUIT}" "Quit" "${C_OFF}"
}

render_close_menu_lines() {
	local -n _l="$1"
	local m=${#_l[@]} i c=1
	for ((i = 0; i < m; i++)); do
		printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_SESS}" "${_l[i]}" "${C_OFF}"
		((++c))
	done
	printf '  %b%2d)%b %b%s%b\n' "${C_NUM}" "${c}" "${C_OFF}" "${C_BACK}" "Back" "${C_OFF}"
}

attach_or_switch() {
	local target="$1"
	if [[ -n "${TMUX:-}" ]]; then
		tmux switch-client -t "$target"
	else
		tmux attach -t "$target"
	fi
}

# Prompt for a name, then create and attach (or switch) to that session.
create_and_join_session() {
	local prompt_msg="$1"
	local name
	read -r -p "$prompt_msg" name || true
	# Trim leading/trailing whitespace only (tmux allows spaces in names).
	name="${name#"${name%%[![:space:]]*}"}"
	name="${name%"${name##*[![:space:]]}"}"
	if [[ -z "$name" ]]; then
		echo "Session name cannot be empty." >&2
		return 1
	fi
	if [[ -n "${TMUX:-}" ]]; then
		tmux new-session -ds "$name"
		tmux switch-client -t "$name"
	else
		tmux new-session -s "$name"
	fi
}

# Pick a session to kill (with confirmation), or Back to return without changes.
close_session_menu() {
	menu_colors_init
	local -a list
	mapfile -t list < <(tmux list-sessions -F '#{session_name}' 2>/dev/null) || true
	if ((${#list[@]} == 0)); then
		echo "No sessions to close." >&2
		return 0
	fi
	# Separate lines: with set -u, max=$((m+1)) in the same `local` as m can run before m exists.
	local m max pick ans num
	m=${#list[@]}
	max=$((m + 1))
	while true; do
		render_close_menu_lines list
		read -r -p "${C_NUM}Session to close (1-${max}):${C_OFF} " num || return 0
		num="${num#"${num%%[![:space:]]*}"}"
		num="${num%"${num##*[![:space:]]}"}"
		if [[ ! "${num}" =~ ^[0-9]+$ ]] || ((num < 1 || num > max)); then
			printf '%b%s%b\n' "${C_ERR}" "Invalid choice; enter 1-${max}." "${C_OFF}" >&2
			continue
		fi
		if ((num == max)); then
			return 0
		fi
		pick="${list[num - 1]}"
		read -r -p "Kill session '${pick}'? [y/N] " ans || true
		ans="${ans#"${ans%%[![:space:]]*}"}"
		ans="${ans%"${ans##*[![:space:]]}"}"
		if [[ ! "${ans}" =~ ^[Yy]([Ee][Ss])?$ ]]; then
			echo "Skipped." >&2
			continue
		fi
		if tmux kill-session -t "$pick"; then
			echo "Closed session: ${pick}"
		else
			echo "Could not close session: ${pick}" >&2
		fi
		return 0
	done
}

main() {
	if ! command -v tmux >/dev/null 2>&1; then
		echo "tmux is not installed or not in PATH." >&2
		return 1
	fi

	menu_colors_init
	local -a sessions
	local n max num
	while true; do
		mapfile -t sessions < <(tmux list-sessions -F '#{session_name}' 2>/dev/null) || true
		if ((${#sessions[@]} == 0)); then
			create_and_join_session "No tmux sessions. New session name: "
			return
		fi
		n=${#sessions[@]}
		max=$((n + 3))
		while true; do
			render_main_menu_lines sessions
			read -r -p "${C_NUM}Enter choice (1-${max}):${C_OFF} " num || return 0
			num="${num#"${num%%[![:space:]]*}"}"
			num="${num%"${num##*[![:space:]]}"}"
			if [[ ! "${num}" =~ ^[0-9]+$ ]] || ((num < 1 || num > max)); then
				printf '%b%s%b\n' "${C_ERR}" "Invalid choice; enter 1-${max}." "${C_OFF}" >&2
				continue
			fi
			if ((num == max)); then
				echo "Aborted." >&2
				return 0
			fi
			if ((num == max - 1)); then
				close_session_menu
				continue 2
			fi
			if ((num == max - 2)); then
				if create_and_join_session "New session name: "; then
					return 0
				fi
				continue 2
			fi
			if ((num >= 1 && num <= n)); then
				attach_or_switch "${sessions[num - 1]}"
				return 0
			fi
		done
	done
}

main "$@"
