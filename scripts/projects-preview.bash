#!/bin/bash
# Preview a project directory with git info, stack detection, and recent files

project_path="${HOME}/$1"

# Git info if available
if [[ -d "${project_path}/.git" ]]; then
    branch=$(cd "${project_path}" && git branch --show-current 2>/dev/null)
    commit=$(cd "${project_path}" && git rev-parse --short HEAD 2>/dev/null)
    echo "📚 Git: ${branch} | ${commit}"
fi

# Project type detection
types=""
[[ -f "${project_path}/package.json" ]] && types+="Node.js "
[[ -f "${project_path}/pyproject.toml" ]] && types+="Python "
[[ -f "${project_path}/requirements.txt" ]] && types+="Python "
[[ -f "${project_path}/go.mod" ]] && types+="Go "
[[ -f "${project_path}/Dockerfile" ]] && types+="Docker "
[[ -f "${project_path}/Cargo.toml" ]] && types+="Rust "
[[ -f "${project_path}/Gemfile" ]] && types+="Ruby "
[[ -f "${project_path}/pom.xml" ]] && types+="Java "
[[ -f "${project_path}/build.gradle" ]] && types+="Java "

if [[ -n "${types}" ]]; then
    echo "🔧 Stack: ${types}"
fi

# Last modified
if command -v gstat &>/dev/null; then
    echo "⏰ Modified: $(gstat -c %y "${project_path}" | cut -d' ' -f1-2)"
elif command -v stat &>/dev/null; then
    echo "⏰ Modified: $(stat -f %Sm -t '%Y-%m-%d %H:%M' "${project_path}")"
fi

echo ""

# Directory tree (one level deep)
lsd --tree --depth 1 --icon=always "${project_path}"
