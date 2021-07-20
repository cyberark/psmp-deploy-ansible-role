# PSMP-Deploy Ansible Role
This Ansible Role will deploy and install CyberArk Privileged Session Manager PSM-SSH including the pre-requisites, application, hardening and selinux

## Requirements
------------

- CentOS / RHEL installed on the remote host
- SSH open on port 22
- The workstation running the playbook must have network connectivity to the remote host
- Administrator access to the remote host
- PSM-SSH CD image


### Flow Variables
Variable                         | Required     | Default                                   | Comments
:--------------------------------|:-------------|:------------------------------------------|:---------
psmp_extract_install             | no           | false                                     | Run the pre install PSMP phase
psmp_pre_install                 | no           | false                                     | Run the pre install PSMP phase
psmp_install                     | no           | false                                     | Run the install PSMP phase
psmp_post_install                | no           | false                                     | Run the post install PSMP phase
psmp_validate_install            | no           | false                                     | Run the validate install PSMP phase
psmp_clean_install               | no           | false                                     | Run the clean PSMP phase


### Deployment Variables
Variable                         | Required     | Default                                              | Comments
:--------------------------------|:-------------|:-----------------------------------------------------|:---------
accept_eula                      | yes          | **No**                                               | Accepting EULA condition (Yes/No)
psmp_zip_file_path               | yes          | None                                                 | CyberArk PSM-SSH installation Zip file package path  
psmp_ignore_checksum             | no           | **false**                                            | Whether to ignore checksum check for the installation
psmp_install_mode                | no           | **Integrated**                                       | Installation mode, accepted values are (Integrated, CustomizedSSHD)
psmp_install_adbridge            | no           | **true**                                             | Whether to also install ADBridge service
psmp_harden_machine              | no           | **false**                                            | Whether to harden the machine during the installation or not
psmp_with_selinux                | no           | **false**                                            | Whether to enforce PSMP with selinux, will also try to install selinux itself
psmp_configure_maintanance_users | no           | **false**                                            | Whether to configure maintenance users and groups for PSMP
psmp_maintanance_users           | no           | root                                                 | List of maintenance users seperated by space
psmp_maintanance_groups          | no           | root                                                 | List of maintenance groups seperated by space, only valid for integrated mode
psmp_allow_sftp                  | no           | **true**                                             | Whether to enable SFTP to the machine after installation
psmp_fetch_install_logs          | no           | **true**                                             | Whether to fetch the installation logs back to the host, will be fetched to either current logs dir or DEFAULT_LOG_PATH env var


## Dependencies
Yum dependencies:
- unzip (For the zip un-archive)

## Usage
The role consists of a number of different tasks which can be enabled or disabled for the particular
run.

`psmp_validate_params`

This task will validate parameters and whether psmp already exists on the machine for upgrade

`psmp_pre_install`

This task will run the PSMP pre install steps.

`psmp_install`

This task will deploy the PSMP to required folder and deploy it

`psmp_validate_install`

This task will validate that the deployment was successful

`psmp_post_install`

This task will run the PSMP post installation steps.

`psmp_clean`

This task will clean PSMP and any related users / groups


## Example Playbook
Below is an example of how you can incorporate this role into an Ansible playbook
to call the PSMP Deploy role with several parameters:

```
---
- include_role:
    name: psmp-deploy
  vars:
    - psmp_extract_install: true
    - psmp_pre_install: true
    - psmp_install: true
    - psmp_post_install: true
    - psmp_validate_install: true
    - psmp_clean_install: false
    - psmp_install_mode: "Integrated"
    - psmp_install_adbridge: true
    - psmp_harden_machine: true
    - psmp_ignore_checksum: true
    - psmp_with_selinux: false
    - accept_eula: "Yes"
    - psmp_zip_file_path: "/tmp/psmp.zip"
    - psmp_fetch_install_logs: true
```

## Running the playbook:
For an example of how to incorporate this role into a complete playbook, please see the
**[pas-orchestrator](https://github.com/cyberark/pas-orchestrator)** example.

## License
Apache License, Version 2.0