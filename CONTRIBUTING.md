# Contributions

Return to [Table of Contents](/README.md#table-of-contents)

* We are using GitFlow https://github.com/nvie/gitflow
* Every commit (inc. code / documentation etc) must go through a Pull Request
    * Pull Request must contain the template below 
* Before merging a Pull Request, in addition to reviewing the code, check the following:
    * Build status
    * Static Code Analysis
    * Code Coverage
    * Documentation
* When merging a Pull Request `Squash` the **Commits** with the **Feature** Description - this is used for the **Changelog**  
    * Do not delete branches once merge as they will contain the **commit history**

---

## Pull Request check list (please include in your PR)

```
| - Q. - | - A. - |
| ------ | ------ |
| Tickets | JIRA # |
| Type | Bug Fix / Feature / Tech Debt |
| BC breaks? | yes / no |
| Deprecations? | yes / no |
| Docs | new / updated / none |
| Build | - SEE SCREENSHOT BELOW - |
| Coverage | - SEE SCREENSHOT BELOW - |
| Quality | - SEE SCREENSHOT BELOW - |
```

![MarkDown Badges](/doc/assets/contributing/badges.png "MarkDown Badges")
