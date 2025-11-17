# VS Code — quick install and getting started

## Install VS Code

Follow instructions on https://code.visualstudio.com/download

## Using SSH Keys to Connect to a Remote Server

Open a terminal and follow these steps:

1. Create a SSH key

If your workstation already has an SSH key, you can skip this step.

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Press Enter to accept default file location and (optional) passphrase. 

2. Copy your public key to the remote server

```
ssh-copy-id user@remote.server.address
```

If `ssh-copy-id` is not available:

Connect to the remote server and append the contents of your public key (`~/.ssh/id_rsa.pub` or similar in your local machine) to the `~/.ssh/authorized_keys` file on the remote server.

3. Connect using your SSH key

```
ssh user@remote.server.address
```

## Using VS Code with Remote SSH

The Remote - SSH extension lets you open folders on remote machines over SSH, edit files, run terminals and use extensions as if they were local.

### 1. Install the extension

In VS Code:
```
Extensions → search "Remote - SSH" → Install
```

### 2. Create a shortcut using SSH config

Edit your SSH config file (`~/.ssh/config`) to add a host entry for easier access. You can open it with the Command Palette (Ctrl+Shift+P) and search `Remote-SSH: Open SSH Configuration File...`.

For example:
```
Host myserver
    HostName remote.server.address
    User user
```

For LBGI sever:
```
Host bipbip
  User <login>
  HostName bipbip
  ProxyJump ssh.lbgi.fr
  ForwardAgent yes
```


### 3. Connect to the server

Option 1: Open the Command Palette (Ctrl+Shift+P) → `Remote-SSH: Connect to Host...` → choose `myserver`.

Option 2: Use the Remote Explorer view (left sidebar) to manage SSH targets.


### Add an SSH key and connect to GitHub / GitLab

1. Generate a key (on the server machine)

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

2. Copy the public key and paste it into GitHub (Settings → SSH and GPG keys):

```bash
cat ~/.ssh/id_rsa.pub
# copy the output and paste in the web UI
```

4. Test the connection:

```bash
ssh -T git@github.com
```


## Useful extensions

Open the Extensions view (Ctrl+Shift+X) and consider installing:
- **GitHub Copilot** — AI code suggestions (requires account/license)
- **Remote - SSH** — work on remote machines over SSH
- **Prettier / EditorConfig** — formatters and conventions
- **ShellCheck** — shell script linter (very useful for training)
- **Markdown All in One** — enhanced Markdown editor
- **vscode-pdf** — PDF viewer inside VS Code (there are several similar extensions for png, svg, markdown preview, etc.)


## Enable GitHub Copilot (brief)

1. Install GitHub Copilot from the marketplace. Follow the authentication flow.
2. After signing in, Copilot provides inline suggestions you can accept with Tab.

## Left activity bar (quick overview)

- Explorer (Ctrl+Shift+E): file browser for the workspace. You can add folders to the workspace using the "Add Folder to Workspace..." option in the Explorer view or "File → Add Folder to Workspace..." menu.
- Search (Ctrl+Shift+F): search across the project
- Source Control (Ctrl+Shift+G): Git staging, commit, push/pull UI
- Run & Debug (Ctrl+Shift+D): launch and debug configurations
- Extensions (Ctrl+Shift+X): install/manage extensions

### Command Palette and Quick Open

- Command Palette: `Ctrl+Shift+P` (or F1) — type any command, e.g. `Remote-SSH: Connect to Host...`.
- Quick open (file): `Ctrl+P` — type a filename, or `:linenumber` to jump to a line.


## Integrated terminal

- Open/close: View → Terminal
- The terminal uses your default shell (bash, zsh, PowerShell). 
- Multiple terminal tabs are supported; run your scripts and see output inline.

## References

- https://code.visualstudio.com/docs/setup/setup-overview