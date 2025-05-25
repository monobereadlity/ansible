# Ansible Collection: monobereadlity.system

This Ansible collection provides a role to disable automatic suspend, hibernation, and related power-saving features on Fedora Linux systems. This is particularly useful for servers or virtual machines where suspend/idle modes are not desired.

## Role Included

*   **`disable_suspend`**:
    *   Configures `/etc/systemd/logind.conf` to ignore suspend-related events:
        *   `HandleSuspendKey=ignore`
        *   `HandleLidSwitch=ignore`
        *   `HandleLidSwitchExternalPower=ignore`
        *   `IdleAction=ignore`
        *   `IdleActionSec=0`
    *   Masks systemd targets: `sleep.target`, `suspend.target`, `hibernate.target`, `hybrid-sleep.target`.
    *   Restarts `systemd-logind` service to apply changes.

## Requirements

*   **Ansible Core Version**: 2.17 or higher.
*   **Supported OS**: Fedora Linux (all versions).
*   **Permissions**: The role requires root privileges to modify system configuration and manage systemd services. Ensure `become: yes` is used or the playbook is run by a privileged user.

## Installation

### Local Installation (from Git checkout)

1.  Clone this repository or ensure it's available on your Ansible control node.
2.  You can then refer to the role directly in your playbook if the `roles_path` includes the directory containing this collection, or by providing a relative path.

    For a standard collection layout (which this repository now follows directly at its root), you would typically install it to one of Ansible's known collection paths.

### Installing from Ansible Galaxy (Hypothetical)

If this collection were published to Ansible Galaxy under the namespace `monobereadlity` and name `system`, you would install it using:

```bash
ansible-galaxy collection install monobereadlity.system
```

## Usage Example

Here's an example playbook demonstrating how to use the `disable_suspend` role:

```yaml
---
- name: Disable automatic suspend on Fedora hosts
  hosts: fedora_servers
  become: yes # Essential for the tasks in the role

  roles:
    # If installed via ansible-galaxy or to a standard collection path:
    - monobereadlity.system.disable_suspend
    # If running directly from this repository structure (e.g., roles path points to './roles'):
    # - disable_suspend
```

To use the role directly from this repository structure without "installing" it as a collection, you might need to adjust your `ansible.cfg` or playbook directory structure. A common way when testing locally is to have a playbook in the root of this repository and an `ansible.cfg` that sets `collections_paths = .` and `roles_path = ./roles`.

However, the most straightforward way to use it as a collection from this local checkout, assuming your playbook is also in this repo, is to ensure your `collections_paths` in `ansible.cfg` (or environment variable `ANSIBLE_COLLECTIONS_PATHS`) points to the parent directory of where `monobereadlity` would reside if it were in the standard `ansible_collections/monobereadlity/system` structure.

Given the current structure (collection directly at root):
If you place your playbook in the root of this repository, you can specify the collection like this:

```yaml
---
- name: Disable automatic suspend on Fedora hosts
  hosts: fedora_servers
  become: yes

  collections:
    - monobereadlity.system # This makes roles available by their short name

  roles:
    - disable_suspend
```
Or, more explicitly, if `ansible.cfg` has `collections_paths = ./:~/.ansible/collections:/usr/share/ansible/collections` (note the `./`):
```yaml
---
- name: Disable automatic suspend on Fedora hosts
  hosts: fedora_servers
  become: yes

  roles:
    - monobereadlity.system.disable_suspend
```


## Development

Ensure you have Ansible installed. No other specific development dependencies are required for the role itself.

## License

MIT
