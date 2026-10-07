# ADR 003 Connection to server

# ADR 003.1 key types
## Status
Accepted

## Context
There are many types of keys when creating a connection, for this project what is the type?

## Options
1. option: ed25519
  - Pros: Secure, constant time runtime, 
  - Cons: Some legacy systems don't support this type
2. option: RSA
  - Pros: Provides the best compatibility of all algorithms
  - Cons: requires the size of the key to be larger to provide "sufficient" security
3. option: ECDSA
  - Pros: all systems support it, was the preferred algorithm
  - Cons: trustworthiness, political and technical concerns

## Decision
ed25519, because it offers more security with much faster performance and smaller key sizes

# ADR 003.2 Server sshd configuration
## Status
Accepted

## Context
There are many ways to change any configuration of my sshd, what is the best way to change it?

## Options
1. Create a new `/etc/ssh/sshd_config.d/<file>`
  - Pros: 
    - Can be isolated from other rules
    - Can make the code more readable
    - Just modifying the rules I want, not the whole config file
  - Cons:
    - In case of having many files, there is a chance that I might overwrite a rule set in another file
    - Must have and follow name conventions
2. Modify the existent `/etc/ssh/sshd_config.d/50-cloud-init.conf`
  - Pros: 
    - The only rule it modifies is similar to the ones I have to modify
    - Not having to create a new file
    - Don't have to overwrite the same rule again 
  - Cons:
    - Might break something if I don't know what that file is used for.
    - Any service or the system itself might regenerate the `/etc/ssh/sshd_config.d/50-cloud-init.conf` file, so all the changes would be lost

3. Keep `/etc/ssh/sshd_config.d/` empty and just modify `/etc/ssh/sshd_config` file
  - Pros:
    - Can read faster the whole file
    - Is just 1 file to read
  - Cons:
    - By default, in the system might exists or something/someone could create a file inside `/etc/ssh/sshd_config.d/` so if I just modify the `/etc/ssh/sshd_config`, the change will not be considered because there's another rule overwriting it

## Decision
`1. create a new file`: This decision is taken for several reasons, right now there is one file in `sshd_config.d` dir, so it is easy to manage, also, is a good practice to have isolated rules and use the name conventions to give a level of priority (first value is the one who is used). Also I don't have to worry about who or what is managing this file (and potentially lose every change done)

# ADR 003.3 Change default port (22) for ssh

## Status
Accepted
## Context
Should I change the default port for my server? What differences would I get?
## Options
1. NO port 22 change:
  - Pros:
    - No extra configuration
  - Cons:
    - Default port is constantly getting scanned
2. Change port to any registered port:
  - Pros:
    - Stop getting scanned by bots
  - Cons:
    - Extra configuration
## Decision
option `2`. Because it reduce automated background noise and bulk brute-force attacks on a server


# ADR 003.4 Password deactivation
## Status
Accepted
## Context
In this project I'm using a private key for ssh connection, so, is there any use case or utility for still using a password?
## Options
1. No deactivate password:
  - Pros:
    - Have other way to connect into the server
  - Cons:
    - A password without a proper configuration might be affected by attackers
    - Having the password is extra configuration that is not really needed 
2. Password deactivation:
  - Pros:
    - Just one entry point for connection
    - More secure than having a password
  - Cons:
    - If I lose the key, I won't be able to connect to the server
## Decision
Deactivate password brings more security to the server, also, having the physical server close and being able to use it directly mitigates the problem of losing the key



