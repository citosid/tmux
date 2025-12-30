#!/bin/bash

function get_workspaces() {
    local base_path=$1
    find "${base_path}" -mindepth 1 -maxdepth 1 \( -type d -o -type l \) -print0
}

function get_projects_from_workspace() {
    local workspace=$1
    find "${workspace}" -mindepth 1 -maxdepth 1 \( -type d -o -type l \) -print0
}

function collect_projects() {
    local -a base_paths=()
    IFS=":" read -r -a base_paths <<<"${TMUX_PROJECTS_BASE_PATH}"
    local -a base_paths
    local -a projects=()

    for base_path in "${base_paths[@]}"; do
        [[ ! -d "${base_path}" ]] && continue

        while IFS= read -r -d $'\0' workspace; do
            while IFS= read -r -d $'\0' project; do
                projects+=("${project#"${HOME}/"}")
            done < <(get_projects_from_workspace "${workspace}")
        done < <(get_workspaces "${base_path}")
    done

    echo "${projects[@]}"
}

function open_project() {
    local -a projects
    projects=($(collect_projects))

    local project_selected
    project_selected=$(printf "%s\n" "${projects[@]}" | fzf-tmux -p \
        --info=hidden \
        --layout=reverse \
        --preview='lsd --icon=always $HOME/{}' \
        --prompt='📦 ' \
        --pointer=' ')
    [[ -z "${project_selected}" ]] && return

    IFS="/" read -r __ workspace_name project_name <<<"${project_selected}"
    
    tmux_switch_or_create_window \
        "${workspace_name}" \
        "${project_name}" \
        "zsh" \
        "${HOME}/${project_selected}"
}

open_project
