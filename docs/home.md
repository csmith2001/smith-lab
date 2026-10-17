# Smith Lab

Smith Lab is a homelab infrastructure platform (IaC) utilizing GitLab, OpenTofu, Ansible, MkDocs, and Active Directory.

## Repository Structure

Smith Docs is a Git submodule mounted to the overarching Smith Lab repository.

This makes it so that documentation has its own history, MkDocs configuration stays isolated, and Obsidian Vault can point directly at the docs repo. This means the infrastructure repo references a specific docs version. This creates a sort of umbreall style project structure which can be represented as:

### Repository Structure

```
smith-lab/
├── .env (Use '.env.example' as reference)
├── .gitlab-ci.yml
├── compose.yml
├── README.md
├── LICENSE
├── docs/ (Git Submodule)
└── infrastructure/
	├── opentofu/ (Generates Desired State)
	└── ansible/ (Applies Desired State)
        ├── ansible.cfg
        ├── Dockerfile
        ├── site.yml
        ├── inventories (Contains inventory information on hosts)
        │   ├── production/
        │   └── staging/
        ├── playbooks/ (Jobs/workflows to be executed on hosts)
        └── roles/ (Specific repeatable roles that can be imported)
```

### Documentation Structure

```
docs/
├── home.md
├── active-directory/
├── architecture/
├── disaster-recovery/
├── infrastructure/
├── inventory/
├── networking/
├── runbooks/
└── standards/
```

### Documentation Categories

| Section           | Purpose                               |
| ----------------- | ------------------------------------- |
| Active Directory  | Domain architecture and operations    |
| Architecture      | Platform and solution designs         |
| Disaster Recovery | Recovery procedures                   |
| Infrastructure    | Infrastructure documentation          |
| Inventory         | Hardware and software assets          |
| Networking        | Network services and topology         |
| Runbooks          | Operational procedures                |
| Standards         | Naming conventions and best practices |

## Related Projects

* smith-lab (TODO LINK REPO)
* smith-docs (TODO LINK REPO)
