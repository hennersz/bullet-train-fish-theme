function fish_prompt
  set -g retval $status
  set -g segment_separator ""
  set -g current_bg normal
  setup_parameters
  test $BULLETTRAIN_PROMPT_ADD_NEWLINE; and echo ""
  if test "$BULLETTRAIN_PROMPT_SEPARATE_LINE" != "true"
    type -q iterm2_prompt_mark; and iterm2_prompt_mark
  end
  for segment in $BULLETTRAIN_PROMPT_ORDER
    eval "prompt_$segment"
  end
  prompt_end
  prompt_char
  reset_color
end

function setup_parameters -d "Set default value if parameter is not declared"
  # prompt
  set -q BULLETTRAIN_PROMPT_CHAR; or set -g BULLETTRAIN_PROMPT_CHAR '$'
  set -q BULLETTRAIN_PROMPT_ROOT; or set -g BULLETTRAIN_PROMPT_ROOT true
  set -q BULLETTRAIN_PROMPT_SEPARATE_LINE; or set -g BULLETTRAIN_PROMPT_SEPARATE_LINE true
  set -q BULLETTRAIN_PROMPT_ADD_NEWLINE; or set -g BULLETTRAIN_PROMPT_ADD_NEWLINE true
  # time
  set -q BULLETTRAIN_TIME_SHOW; or set -g BULLETTRAIN_TIME_SHOW true
  set -q BULLETTRAIN_TIME_12HR; or set -g BULLETTRAIN_TIME_12HR
  set -q BULLETTRAIN_TIME_BG; or set -g BULLETTRAIN_TIME_BG white
  set -q BULLETTRAIN_TIME_FG; or set -g BULLETTRAIN_TIME_FG black
  # status
  set -q BULLETTRAIN_STATUS_SHOW; or set -g BULLETTRAIN_STATUS_SHOW true
  set -q BULLETTRAIN_STATUS_EXIT_SHOW; or set -g BULLETTRAIN_STATUS_EXIT_SHOW
  set -q BULLETTRAIN_STATUS_BG; or set -g BULLETTRAIN_STATUS_BG green
  set -q BULLETTRAIN_STATUS_ERROR_BG; or set -g BULLETTRAIN_STATUS_ERROR_BG red
  set -q BULLETTRAIN_STATUS_FG; or set -g BULLETTRAIN_STATUS_FG white
  set -q BULLETTRAIN_STATUS_ERROR; or set -g BULLETTRAIN_STATUS_ERROR "✘"
  set -q BULLETTRAIN_STATUS_ROOT; or set -g BULLETTRAIN_STATUS_ROOT "⚡"
  set -q BULLETTRAIN_STATUS_JOB; or set -g BULLETTRAIN_STATUS_JOB "⚙"
  # custom
  set -q BULLETTRAIN_CUSTOM_MSG; or set -g BULLETTRAIN_CUSTOM_MSG
  set -q BULLETTRAIN_CUSTOM_BG; or set -g BULLETTRAIN_CUSTOM_BG black
  set -q BULLETTRAIN_CUSTOM_FG; or set -g BULLETTRAIN_CUSTOM_FG white
  # context
  set -q BULLETTRAIN_CONTEXT_SHOW; or set -g BULLETTRAIN_CONTEXT_SHOW
  set -q BULLETTRAIN_CONTEXT_BG; or set -g BULLETTRAIN_CONTEXT_BG black
  set -q BULLETTRAIN_CONTEXT_FG; or set -g BULLETTRAIN_CONTEXT_FG white
  set -q BULLETTRAIN_CONTEXT_DEFAULT_USER; or set -g BULLETTRAIN_CONTEXT_DEFAULT_USER
  set -q BULLETTRAIN_CONTEXT_HOSTNAME; or set -g BULLETTRAIN_CONTEXT_HOSTNAME (hostname -s)
  set -q BULLETTRAIN_IS_SSH_CLIENT;
    or if test -n "$SSH_CONNECTION" -o -n "$SSH_TTY" -o -n "$SSH_CLIENT";
      set -g BULLETTRAIN_IS_SSH_CLIENT true
    else
      set -g BULLETTRAIN_IS_SSH_CLIENT
    end
  # dir
  set -q BULLETTRAIN_DIR_SHOW; or set -g BULLETTRAIN_DIR_SHOW true
  set -q BULLETTRAIN_DIR_BG; or set -g BULLETTRAIN_DIR_BG blue
  set -q BULLETTRAIN_DIR_FG; or set -g BULLETTRAIN_DIR_FG white
  set -q BULLETTRAIN_DIR_CONTEXT_SHOW; or set -g BULLETTRAIN_DIR_CONTEXT_SHOW
  set -q BULLETTRAIN_DIR_EXTENDED; or set -g BULLETTRAIN_DIR_EXTENDED 3
  # perl
  set -q BULLETTRAIN_PERL_SHOW; or set -g BULLETTRAIN_PERL_SHOW
  set -q BULLETTRAIN_PERL_BG; or set -g BULLETTRAIN_PERL_BG yellow
  set -q BULLETTRAIN_PERL_FG; or set -g BULLETTRAIN_PERL_FG white
  set -q BULLETTRAIN_PERL_PREFIX; or set -g BULLETTRAIN_PERL_PREFIX "🐪 "
  # ruby
  set -q BULLETTRAIN_RUBY_SHOW; or set -g BULLETTRAIN_RUBY_SHOW
  set -q BULLETTRAIN_RUBY_BG; or set -g BULLETTRAIN_RUBY_BG magenta
  set -q BULLETTRAIN_RUBY_FG; or set -g BULLETTRAIN_RUBY_FG white
  set -q BULLETTRAIN_RUBY_PREFIX; or set -g BULLETTRAIN_RUBY_PREFIX "💎 "
  set -q BULLETTRAIN_RUBY_SHOW_SYSTEM; or set -g BULLETTRAIN_RUBY_SHOW_SYSTEM true
  # python
  set -q BULLETTRAIN_PYTHON_SHOW; or set -g BULLETTRAIN_PYTHON_SHOW
  set -q BULLETTRAIN_PYTHON_BG; or set -g BULLETTRAIN_PYTHON_BG yellow
  set -q BULLETTRAIN_PYTHON_FG; or set -g BULLETTRAIN_PYTHON_FG white
  set -q BULLETTRAIN_PYTHON_PREFIX; or set -g BULLETTRAIN_PYTHON_PREFIX "🐍 "
  set -q BULLETTRAIN_PYTHON_SHOW_SYSTEM; or set -g BULLETTRAIN_PYTHON_SHOW_SYSTEM true
  set -q VIRTUAL_ENV_DISABLE_PROMPT; or set -g VIRTUAL_ENV_DISABLE_PROMPT true
  # node
  set -q BULLETTRAIN_NODEJS_SHOW; or set -g BULLETTRAIN_NODEJS_SHOW
  set -q BULLETTRAIN_NODEJS_BG; or set -g BULLETTRAIN_NODEJS_BG green
  set -q BULLETTRAIN_NODEJS_FG; or set -g BULLETTRAIN_NODEJS_FG white
  set -q BULLETTRAIN_NODEJS_PREFIX; or set -g BULLETTRAIN_NODEJS_PREFIX ⬢
  # go
  set -q BULLETTRAIN_GO_SHOW; or set -g BULLETTRAIN_GO_SHOW
  set -q BULLETTRAIN_GO_BG; or set -g BULLETTRAIN_GO_BG cyan
  set -q BULLETTRAIN_GO_FG; or set -g BULLETTRAIN_GO_FG white
  set -q BULLETTRAIN_GO_PREFIX; or set -g BULLETTRAIN_GO_PREFIX "🐭 "
  # git
  set -q BULLETTRAIN_GIT_SHOW; or set -g BULLETTRAIN_GIT_SHOW true
  set -q BULLETTRAIN_GIT_COLORIZE_DIRTY; or set -g BULLETTRAIN_GIT_COLORIZE_DIRTY
  set -q BULLETTRAIN_GIT_COLORIZE_DIRTY_BG; or set -g BULLETTRAIN_GIT_COLORIZE_DIRTY_BG yellow
  set -q BULLETTRAIN_GIT_COLORIZE_DIRTY_FG; or set -g BULLETTRAIN_GIT_COLORIZE_DIRTY_FG black
  set -q BULLETTRAIN_GIT_BG; or set -g BULLETTRAIN_GIT_BG white
  set -q BULLETTRAIN_GIT_FG; or set -g BULLETTRAIN_GIT_FG black
  # set -q BULLETTRAIN_GIT_PROMPT_CMD; or set -g BULLETTRAIN_GIT_PROMPT_CMD git_prompt_info
  set -q BULLETTRAIN_GIT_EXTENDED; or set -g BULLETTRAIN_GIT_EXTENDED true
  set -q BULLETTRAIN_GIT_PREFIX; or set -g BULLETTRAIN_GIT_PREFIX 
  set -q BULLETTRAIN_GIT_SUFFIX; or set -g BULLETTRAIN_GIT_SUFFIX
  set -q BULLETTRAIN_GIT_DIRTY_FG; or set -g BULLETTRAIN_GIT_DIRTY_FG red
  set -q BULLETTRAIN_GIT_DIRTY; or set -g BULLETTRAIN_GIT_DIRTY ✘
  set -q BULLETTRAIN_GIT_CLEAN_FG; or set -g BULLETTRAIN_GIT_CLEAN_FG green
  set -q BULLETTRAIN_GIT_CLEAN; or set -g BULLETTRAIN_GIT_CLEAN ✔
  set -q BULLETTRAIN_GIT_ADDED_FG; or set -g BULLETTRAIN_GIT_ADDED_FG green
  set -q BULLETTRAIN_GIT_ADDED; or set -g BULLETTRAIN_GIT_ADDED ✚
  set -q BULLETTRAIN_GIT_MODIFIED_FG; or set -g BULLETTRAIN_GIT_MODIFIED_FG blue
  set -q BULLETTRAIN_GIT_MODIFIED; or set -g BULLETTRAIN_GIT_MODIFIED ✹
  set -q BULLETTRAIN_GIT_DELETED_FG; or set -g BULLETTRAIN_GIT_DELETED_FG red
  set -q BULLETTRAIN_GIT_DELETED; or set -g BULLETTRAIN_GIT_DELETED ✖
  set -q BULLETTRAIN_GIT_UNTRACKED_FG; or set -g BULLETTRAIN_GIT_UNTRACKED_FG yellow
  set -q BULLETTRAIN_GIT_UNTRACKED; or set -g BULLETTRAIN_GIT_UNTRACKED ✭
  set -q BULLETTRAIN_GIT_RENAMED_FG; or set -g BULLETTRAIN_GIT_RENAMED_FG black
  set -q BULLETTRAIN_GIT_RENAMED; or set -g BULLETTRAIN_GIT_RENAMED ➜
  set -q BULLETTRAIN_GIT_UNMERGED_FG; or set -g BULLETTRAIN_GIT_UNMERGED_FG black
  set -q BULLETTRAIN_GIT_UNMERGED; or set -g BULLETTRAIN_GIT_UNMERGED ═
  set -q BULLETTRAIN_GIT_STASHED_FG; or set -g BULLETTRAIN_GIT_STASHED_FG black
  set -q BULLETTRAIN_GIT_STASHED; or set -g BULLETTRAIN_GIT_STASHED ◼
  set -q BULLETTRAIN_GIT_AHEAD_FG; or set -g BULLETTRAIN_GIT_AHEAD_FG black
  set -q BULLETTRAIN_GIT_AHEAD; or set -g BULLETTRAIN_GIT_AHEAD ⬆
  set -q BULLETTRAIN_GIT_BEHIND_FG; or set -g BULLETTRAIN_GIT_BEHIND_FG black
  set -q BULLETTRAIN_GIT_BEHIND; or set -g BULLETTRAIN_GIT_BEHIND ⬇
  set -q BULLETTRAIN_GIT_DIVERGED_FG; or set -g BULLETTRAIN_GIT_DIVERGED_FG black
  set -q BULLETTRAIN_GIT_DIVERGED; or set -g BULLETTRAIN_GIT_DIVERGED ⬍
  set -q BULLETTRAIN_GIT_DISABLE_UNTRACKED_FILES_DIRTY; or set -g BULLETTRAIN_GIT_DISABLE_UNTRACKED_FILES_DIRTY
  # mercurial/hg
  set -q BULLETTRAIN_HG_SHOW; or set -g BULLETTRAIN_HG_SHOW
  set -q BULLETTRAIN_HG_COLORIZE_DIRTY; or set -g BULLETTRAIN_HG_COLORIZE_DIRTY
  set -q BULLETTRAIN_HG_COLORIZE_DIRTY_BG; or set -g BULLETTRAIN_HG_COLORIZE_DIRTY_BG yellow
  set -q BULLETTRAIN_HG_COLORIZE_DIRTY_FG; or set -g BULLETTRAIN_HG_COLORIZE_DIRTY_FG black
  set -q BULLETTRAIN_HG_BG; or set -g BULLETTRAIN_HG_BG white
  set -q BULLETTRAIN_HG_FG; or set -g BULLETTRAIN_HG_FG black
  set -q BULLETTRAIN_HG_PREFIX; or set -g BULLETTRAIN_HG_PREFIX ☿
  set -q BULLETTRAIN_HG_DIRTY; or set -g BULLETTRAIN_HG_DIRTY ±
  set -q BULLETTRAIN_HG_NOT_ADDED_FG; or set -g BULLETTRAIN_HG_NOT_ADDED_FG green
  set -q BULLETTRAIN_HG_MODIFIED_FG; or set -g BULLETTRAIN_HG_MODIFIED_FG blue
  # kubernetes context
  set -q BULLETTRAIN_KCTX_SHOW; or set -g BULLETTRAIN_KCTX_SHOW
  set -q BULLETTRAIN_KCTX_BG; or set -g BULLETTRAIN_KCTX_BG yellow
  set -q BULLETTRAIN_KCTX_FG; or set -g BULLETTRAIN_KCTX_FG white
  set -q BULLETTRAIN_KCTX_PREFIX; or set -g BULLETTRAIN_KCTX_PREFIX ⎈
  set -q BULLETTRAIN_KCTX_KCONFIG; or set -g BULLETTRAIN_KCTX_KCONFIG "$HOME/.kube/config"
  set -q BULLETTRAIN_KCTX_KUBECTL; or set -g BULLETTRAIN_KCTX_KUBECTL true
  set -q BULLETTRAIN_KCTX_NAMESPACE; or set -g BULLETTRAIN_KCTX_NAMESPACE true
  set -q BULLETTRAIN_KCTX_AK_URL; or set -g BULLETTRAIN_KCTX_AK_URL
  # time
  set -q BULLETTRAIN_EXEC_TIME_SHOW; or set -g BULLETTRAIN_EXEC_TIME_SHOW true
  set -q BULLETTRAIN_EXEC_TIME_ELAPSED; or set -g BULLETTRAIN_EXEC_TIME_ELAPSED 5
  set -q BULLETTRAIN_EXEC_TIME_BG; or set -g BULLETTRAIN_EXEC_TIME_BG yellow
  set -q BULLETTRAIN_EXEC_TIME_FG; or set -g BULLETTRAIN_EXEC_TIME_FG black
  # dir_env
  set -q BULLETTRAIN_DIR_ENV_SHOW; or set -g BULLETTRAIN_DIR_ENV_SHOW
  set -q BULLETTRAIN_DIR_ENV_BG; or set -g BULLETTRAIN_DIR_ENV_BG yellow
  set -q BULLETTRAIN_DIR_ENV_FG; or set -g BULLETTRAIN_DIR_ENV_FG black
  set -q BULLETTRAIN_DIR_ENV_PATH_SHOW; or set -g BULLETTRAIN_DIR_ENV_PATH_SHOW
  set -q BULLETTRAIN_DIR_ENV_PREFIX; or set -g BULLETTRAIN_DIR_ENV_PREFIX " "
  set -q BULLETTRAIN_DIR_ENV_NIX_PREFIX; or set -g BULLETTRAIN_DIR_ENV_NIX_PREFIX " "
  set -q BULLETTRAIN_DIR_ENV_MSG; or set -g BULLETTRAIN_DIR_ENV_MSG
  set -l _prompt_order \
    time \
    status \
    custom \
    context \
    kctx \
    dir_env \
    dir \
    perl \
    ruby \
    python \
    nodejs \
    go \
    git \
    hg \
    cmd_exec_time
  test "$BULLETTRAIN_PROMPT_ORDER"; or set -g BULLETTRAIN_PROMPT_ORDER $_prompt_order
end

function show-git
  set -gx BULLETTRAIN_GIT_SHOW true
end

function hide-git
  set -gu BULLETTRAIN_GIT_SHOW
end

function show-python
  set -gx BULLETTRAIN_PYTHON_SHOW true
end

function hide-python
  set -gu BULLETTRAIN_PYTHON_SHOW
end

function show-node
  set -gx BULLETTRAIN_NODEJS_SHOW true
end

function hide-node
  set -gu BULLETTRAIN_NODEJS_SHOW
end

function show-go
  set -gx BULLETTRAIN_GO_SHOW true
end

function hide-go
  set -gu BULLETTRAIN_GO_SHOW
end

function show-ruby
  set -gx BULLETTRAIN_RUBY_SHOW true
end

function hide-ruby
  set -gu BULLETTRAIN_RUBY_SHOW
end

function show-perl
  set -gx BULLETTRAIN_PERL_SHOW true
end

function hide-perl
  set -gu BULLETTRAIN_PERL_SHOW
end

function show-k8s
  set -gx BULLETTRAIN_KCTX_SHOW true
end

function hide-k8s
  set -gu BULLETTRAIN_KCTX_SHOW
end

function prompt_segment -a bg fg prompt
  set -l _bg
  set -l _fg
  set -l _separates
  test $bg; and set _bg $bg; or set _bg normal
  test $fg; and set _fg $fg; or set _fg normal
  test "$current_bg" != "normal";
    and test "$bg" != "$current_bg";
      and set _separates true
  prompt_separator $_bg $_fg $_separates
  echo -n " "
  set current_bg $bg
  test $prompt; and echo -n "$prompt"
end

function prompt_separator -a bg fg separates
  if test $separates
    echo -n " "
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator"
  else
    set_color -b $bg
  end
  set_color $fg
end

function prompt_end
  prompt_separator normal normal $current_bg
  set -e current_bg
end

function reset_color
  set_color normal
end

function prompt_char
  if test "$BULLETTRAIN_PROMPT_SEPARATE_LINE" = "true"
    echo ""
    type -q iterm2_prompt_mark; and iterm2_prompt_mark
  else
    echo -n " "
  end

  set -l _fg normal
  test (whoami) = "root"; and set _fg green

  set_color $_fg
  echo -n "$BULLETTRAIN_PROMPT_CHAR "
end

function prompt_time -d "Show current time"
  test "$BULLETTRAIN_TIME_SHOW" = "true"; or return

  test "$BULLETTRAIN_TIME_12HR" = "true";
    and prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG (date "+%r");
    or  prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG (date "+%T")
end

function prompt_status -d "Show last command status"
  test "$BULLETTRAIN_STATUS_SHOW" = "true"; or return

  set -l _bg
  set -l _fg $BULLETTRAIN_STATUS_FG
  set -l _symbols
  if test $retval != 0
    set _bg $BULLETTRAIN_STATUS_ERROR_BG
    set _symbols $_symbols $BULLETTRAIN_STATUS_ERROR
    test "$BULLETTRAIN_STATUS_EXIT_SHOW" = "true";
      and set _symbols $_symbols $retval
  else
    set _bg $BULLETTRAIN_STATUS_BG
  end
  test (id -u) -eq 0; and set _symbols $_symbols $BULLETTRAIN_STATUS_ROOT
  test (jobs -l | wc -l) -gt 0; and set _symbols $_symbols $BULLETTRAIN_STATUS_JOB
  test "$_symbols"; and prompt_segment $_bg $_fg "$_symbols"
end

function prompt_custom -d "Show custome message"
  test "$BULLETTRAIN_CUSTOM_MSG"; or return

  prompt_segment $BULLETTRAIN_CUSTOM_BG $BULLETTRAIN_CUSTOM_FG $BULLETTRAIN_CUSTOM_MSG
end

function context
  set -l _context

  if test -n "$BULLETTRAIN_IS_SSH_CLIENT" -a "$USER" != "$BULLETTRAIN_CONTEXT_DEFAULT_USER"
    echo -n "$USER@$BULLETTRAIN_CONTEXT_HOSTNAME"
  else if test -n "$BULLETTRAIN_IS_SSH_CLIENT"
    echo -n $BULLETTRAIN_CONTEXT_HOSTNAME
  else if test "$USER" != "$BULLETTRAIN_CONTEXT_DEFAULT_USER"
    echo -n $USER
  end
end

function prompt_context -d "Show context"
  test "$BULLETTRAIN_CONTEXT_SHOW" = "true"; or return

  set -l _context (context)
  test "$_context";
    and prompt_segment $BULLETTRAIN_CONTEXT_BG $BULLETTRAIN_CONTEXT_FG $_context
end

function prompt_dir -d "Show current directory"
  test "$BULLETTRAIN_DIR_SHOW" = "true"; or return

  set -l _dir
  test "$BULLETTRAIN_DIR_CONTEXT_SHOW" = "true";
    and set -l _context (context);
      and test "$_context";
        and set _dir "$_context:"

  switch $BULLETTRAIN_DIR_EXTENDED
  case -1
    set _dir "$_dir$PWD"
  case "*"
    set -g fish_prompt_pwd_dir_length $BULLETTRAIN_DIR_EXTENDED
    set _dir "$_dir"(prompt_pwd)
  end

  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG "$_dir"
end

function prompt_perl -d "Show perl environment"
  test "$BULLETTRAIN_PERL_SHOW" = "true"; or return

  test (command -v plenv);
    and set -l _version $BULLETTRAIN_PERL_PREFIX (plenv version | sed 's/ (set.*$//');
      and prompt_segment $BULLETTRAIN_PERL_BG $BULLETTRAIN_PERL_FG "$_version"
end

function prompt_ruby -d "Show ruby environment"
  test "$BULLETTRAIN_RUBY_SHOW" = "true"; or return

  set -l _ruby_prompt
  if test (command -v rbenv)
    set -l _version (rbenv version | sed 's/ (set.*$//')
    set -l _gemset (rbenv gemset active 2> /dev/null | sed 's/ global$//')
    test "$_gemset";
      and set _ruby_prompt $_version"@"$_gemset;
      or  set _ruby_prompt $_version
  else if test (command -v rvm-prompt)
    set _ruby_prompt (rvm-prompt i v g)
  else if test (command -v chruby)
    set _ruby_prompt (chruby | sed -n -e 's/ \* //p')
  else if test (command -v asdf)
    set _ruby_prompt (asdf current ruby &| sed 's/ruby[[:space:]]*//' | sed 's/[[:space:]].*//')
  end

  switch "$_ruby_prompt"
  case 'system*'
    test "$BULLETTRAIN_RUBY_SHOW_SYSTEM" = "true"; or return
  end

  test "$_ruby_prompt";
    and set _ruby_prompt $BULLETTRAIN_RUBY_PREFIX $_ruby_prompt;
      and prompt_segment $BULLETTRAIN_RUBY_BG $BULLETTRAIN_RUBY_FG "$_ruby_prompt"
end

function prompt_python -d "Show python environment"
  test "$BULLETTRAIN_PYTHON_SHOW" = "true"; or return

  set -l _python_prompt
  if test "$VIRTUAL_ENV" -a "$VIRTUAL_ENV_DISABLE_PROMPT" = "true"
    set _python_prompt (basename $VIRTUAL_ENV)
  else if test (command -v pyenv)
    set _python_prompt (pyenv version-name | sed 's/:.*$//' )
  else if test (command -v asdf)
    set _python_prompt (asdf current python &| sed 's/python[[:space:]]*//' | sed 's/[[:space:]].*//')
  end

  switch "$_python_prompt"
  case 'system*'
    test "$BULLETTRAIN_PYTHON_SHOW_SYSTEM" = "true"; or return
  end

  test "$_python_prompt";
    and set _python_prompt $BULLETTRAIN_PYTHON_PREFIX $_python_prompt;
      and prompt_segment $BULLETTRAIN_PYTHON_BG $BULLETTRAIN_PYTHON_FG "$_python_prompt"
end

function prompt_nodejs -d "Show node.js environment"
  test "$BULLETTRAIN_NODEJS_SHOW" = "true"; or return

  set -l _nodejs_prompt
  if test (command -v nvm)
    set _nodejs_prompt (nvm current 2> /dev/null);
  else if test (command -v asdf)
    set _nodejs_prompt (asdf current nodejs &| sed 's/nodejs[[:space:]]*//' | sed 's/[[:space:]].*//')
  else if test (command -v node)
    set _nodejs_prompt (node --version 2> /dev/null | tail -n1)
  end

  test "$_nodejs_prompt";
    and set _nodejs_prompt $BULLETTRAIN_NODEJS_PREFIX $_nodejs_prompt;
      and prompt_segment $BULLETTRAIN_NODEJS_BG $BULLETTRAIN_NODEJS_FG "$_nodejs_prompt"
end

function prompt_go -d "Show go environment"
  test "$BULLETTRAIN_GO_SHOW" = "true"; or return

  set -l _go_prompt
  if test (command -v asdf)
    set _go_prompt (asdf current golang &| sed 's/golang[[:space:]]*//' | sed 's/[[:space:]].*//')
  else if test (command -v go)
    and set _go_prompt (go version | grep --colour=never -oE '[[:digit:]].[[:digit:]]+')
  end

  test "$_go_prompt";
    and set _go_prompt $BULLETTRAIN_GO_PREFIX $_go_prompt;
      and prompt_segment $BULLETTRAIN_GO_BG $BULLETTRAIN_GO_FG "$_go_prompt"
end

function prompt_git -d "Show git working tree info"
  test "$BULLETTRAIN_GIT_SHOW" = "true"; or return
  test (command -v git); or return
  test (git rev-parse --is-inside-work-tree 2> /dev/null); or return

  set -l _bg $BULLETTRAIN_GIT_BG
  set -l _fg $BULLETTRAIN_GIT_FG
  set -l _is_dirty (is_git_dirty)

  test "$BULLETTRAIN_GIT_COLORIZE_DIRTY" = "true";
    and test "$_is_dirty";
      and set _bg $BULLETTRAIN_GIT_COLORIZE_DIRTY_BG;
        and set _fg $BULLETTRAIN_GIT_COLORIZE_DIRTY_FG

  git_prompt_info $_bg $_fg $_is_dirty
  test "$BULLETTRAIN_GIT_EXTENDED" = "true"; and git_prompt_status $_bg $_fg
end

function git_prompt_info -a bg fg is_dirty
  set -l ref (git symbolic-ref HEAD 2> /dev/null);
    or set ref (git rev-parse --short HEAD 2> /dev/null);
      or return 0

  set -l _dirty $BULLETTRAIN_GIT_CLEAN
  test "$is_dirty" = "true"; and set _dirty $BULLETTRAIN_GIT_DIRTY;
  test "$BULLETTRAIN_GIT_PREFIX"; and prompt_segment $bg $fg $BULLETTRAIN_GIT_PREFIX
  prompt_segment $bg $fg (echo $ref | sed "s-refs/heads/--")
  test "$_dirty"; and prompt_segment $bg (test "$is_dirty" = "true"; and echo $BULLETTRAIN_GIT_DIRTY_FG; or echo $fg) $_dirty
  test "$BULLETTRAIN_GIT_SUFFIX"; and prompt_segment $bg $fg $BULLETTRAIN_GIT_SUFFIX
end

function is_git_dirty
  set -l _flgs "--porcelain"
  set -l _post_1_7_2_git (git_compare_version "1.7.2")
  test $_post_1_7_2_git -gt 0;
    set _flags $_flgs "--ignore-submodules=dirty"
  test "$BULLETTRAIN_GIT_DISABLE_UNTRACKED_FILES_DIRTY" = "true";
    set _flags $_flgs "--untracked-files=no"
  set -l _status (git status "$_flgs" 2> /dev/null | tail -n1)
  test "$_status"; and echo true
end

function git_compare_version -a git_version
  set -l _input_git_version (string split "." $git_version)
  set -l _installed_git_version (string split "." (git --version 2> /dev/null | cut -d' ' -f3))
  for i in (seq 3)
    test $_installed_git_version[$i] -gt $_input_git_version[$i];
      and echo 1;
        and return 0
    test $_installed_git_version[$i] -lt $_input_git_version[$i];
      and echo -1;
        and return 0
  end
  echo 0
end

function git_prompt_status -a bg fg
  git status --porcelain -b 2> /dev/null | read -lz _index
  test (find_from_lines '^## [^ ]\+ .*diverged' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_DIVERGED_FG $BULLETTRAIN_GIT_DIVERGED
  test (find_from_lines '^## [^ ]\+ .*behind' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_BEHIND_FG $BULLETTRAIN_GIT_BEHIND
  test (find_from_lines '^## [^ ]\+ .*ahead' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_AHEAD_FG $BULLETTRAIN_GIT_AHEAD
  test (find_from_lines '^UU ' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_UNMERGED_FG $BULLETTRAIN_GIT_UNMERGED
  test (git rev-parse --verify refs/stash 2> /dev/null);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_STASHED_FG $BULLETTRAIN_GIT_STASHED
  if begin test (find_from_lines '^ D ' $_index);
    or test (find_from_lines '^D  ' $_index);
    or test (find_from_lines '^AD ' $_index); end;
    git_prompt_segment $bg $fg $BULLETTRAIN_GIT_DELETED_FG $BULLETTRAIN_GIT_DELETED
  end
  test (find_from_lines '^R  ' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_RENAMED_FG $BULLETTRAIN_GIT_RENAMED
  if begin test (find_from_lines '^ M ' $_index);
    or test (find_from_lines '^AM ' $_index);
    or test (find_from_lines '^ T ' $_index); end;
    git_prompt_segment $bg $fg $BULLETTRAIN_GIT_MODIFIED_FG $BULLETTRAIN_GIT_MODIFIED
  end
  if begin test (find_from_lines '^A  ' $_index);
    or test (find_from_lines '^M  ' $_index); end;
    git_prompt_segment $bg $fg $BULLETTRAIN_GIT_ADDED_FG $BULLETTRAIN_GIT_ADDED
  end
  test (find_from_lines '^\?\? ' $_index);
    and git_prompt_segment $bg $fg $BULLETTRAIN_GIT_UNTRACKED_FG $BULLETTRAIN_GIT_UNTRACKED
end

function find_from_lines -a expr lines
  test (echo $lines | grep -E $expr | tail -n1); and echo true;
end

function git_prompt_segment -a bg base_fg fg prompt
  test -n "$prompt"; or return
  set -l _fg $base_fg
  test "$fg"; and set _fg $fg
  prompt_segment $bg $_fg $prompt
end

function prompt_hg -d "Show mercurial working tree info"
  test "$BULLETTRAIN_HG_SHOW" = "true"; or return
  test (command -v hg); or return

  set -l _hg_id (hg id -nb 2> /dev/null)
  test "$_hg_id"; or return

  set -l _rev (echo $_hg_id | cut -d' ' -f1 | sed 's/[^-0-9]//g')
  set -l _branch (echo $_hg_id | cut -d' ' -f2)
  set -l _hg_prompt $BULLETTRAIN_HG_PREFIX "$_rev@$_branch"
  set -l _dirty_fg
  hg st | read -lz _hg_st
  if test (find_from_lines "^\?" $_hg_st);
    set _dirty_fg $BULLETTRAIN_HG_NOT_ADDED_FG
  else if test (find_from_lines "^(M|A)" $_hg_st);
    set _dirty_fg $BULLETTRAIN_HG_MODIFIED_FG
  end

  set -l _bg $BULLETTRAIN_HG_BG
  set -l _fg $BULLETTRAIN_HG_FG
  test "$BULLETTRAIN_HG_COLORIZE_DIRTY" = "true";
    and test "$_dirty_fg";
      and set _bg $BULLETTRAIN_HG_COLORIZE_DIRTY_BG;
        and set _fg $BULLETTRAIN_HG_COLORIZE_DIRTY_FG
  prompt_segment $_bg $_fg "$_hg_prompt"

  test "$_dirty_fg";
    and set _fg $_dirty_fg;
      and prompt_segment $_bg $_fg $BULLETTRAIN_HG_DIRTY
end

function prompt_kctx -d "Show Kubernetes context"
  test "$BULLETTRAIN_KCTX_SHOW" = "true"; or return
  set -l _kctx_prompt

  if test "$BULLETTRAIN_KCTX_AK_URL" = "true"
    set -l ak_context "none"
    if test -n "$AK_URL"
      if string match -q "*kind" "$AK_URL"
        set ak_context (echo $AK_URL | cut -d'/' -f3)
      else if string match -q "file://*" $AK_URL
        set ak_context (akutil context current | cut -d'/' -f5)
      else
        set ak_context (echo $AK_URL | cut -d'/' -f5 | cut -d'?' -f1)
      end
    end
    set _kctx_prompt $ak_context
  else if test "$BULLETTRAIN_KCTX_KUBECTL" = "true"; and test (command -v kubectl)
    set -l _jsonpath '{.current-context}'
    test "$BULLETTRAIN_KCTX_NAMESPACE" = "true";
      and set _jsonpath "$_jsonpath{':'}{..namespace}"
    set _kctx_prompt (kubectl config view --minify --output "jsonpath=$_jsonpath" 2>/dev/null)
  else if test -f $BULLETTRAIN_KCTX_KCONFIG
    set _kctx_prompt (cat $BULLETTRAIN_KCTX_KCONFIG | grep current-context | awk '{print $2}')
  end

  test "$_kctx_prompt";
    and set _kctx_prompt $BULLETTRAIN_KCTX_PREFIX $_kctx_prompt;
      and prompt_segment $BULLETTRAIN_KCTX_BG $BULLETTRAIN_KCTX_FG "$_kctx_prompt"
end

function displaytime -a t
  set -l _d (math "floor($t/60/60/24)")
  set -l _h (math "floor($t/60/60)%24")
  set -l _m (math "floor($t/60)%60")
  set -l _s (math "floor($t)%60")
  test $_d -gt 0; and printf '%dd' $_d
  test $_h -gt 0; and printf '%dh' $_h
  test $_m -gt 0; and printf '%dm' $_m
  printf '%ds' $_s
end

function prompt_cmd_exec_time -d "Show last command exection time"
  test "$BULLETTRAIN_EXEC_TIME_SHOW" = "true"; or return

  set -l duration
  test "$CMD_DURATION";
    and set _duration (math $CMD_DURATION/1000);
    and test $_duration -gt $BULLETTRAIN_EXEC_TIME_ELAPSED;
    and prompt_segment \
      $BULLETTRAIN_EXEC_TIME_BG \
      $BULLETTRAIN_EXEC_TIME_FG \
      (displaytime $_duration);
end

function prompt_dir_env
  test "$BULLETTRAIN_DIR_ENV_SHOW" = "true"; or return

  set -l _dir_env_prompt
  if set -q DIRENV_DIR

    set -l _trimmed_dir (echo $DIRENV_DIR | string trim --left --chars=-)
    if test "$BULLETTRAIN_DIR_ENV_PATH_SHOW" = "true"
      set _dir_env_prompt "$_trimmed_dir"
    else
      set _dir_env_prompt "$BULLETTRAIN_DIR_ENV_MSG"
    end

    set -l _env_file
    if test -f "$_trimmed_dir/.envrc"
      set _env_file "$_trimmed_dir/.envrc"
    else if test -f "$_trimmed_dir/.env"
      set _env_file "$_trimmed_dir/.env"
    end

    if test (cat "$_env_file" | string trim) = "use_nix";
      set _dir_env_prompt "$BULLETTRAIN_DIR_ENV_NIX_PREFIX" "$_dir_env_prompt"
    else if test (cat "$_env_file" | string trim) = "use flake --impure"
      set _dir_env_prompt "$BULLETTRAIN_DIR_ENV_NIX_PREFIX" "$_dir_env_prompt"
    else
      set _dir_env_prompt "$BULLETTRAIN_DIR_ENV_PREFIX" "$_dir_env_prompt"
    end

    prompt_segment $BULLETTRAIN_DIR_ENV_BG $BULLETTRAIN_DIR_ENV_FG "$_dir_env_prompt"
  end
end
