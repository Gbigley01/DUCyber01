## Common PowerShell Commands

| CMDlet          | Function                                         | Equivalent Command     |
| --------------- | ------------------------------------------------ | ---------------------- |
| `Set-Location`  | Changes to specified directory                   | `cd`                   |
| `Get-ChildItem` | Return current directory contents             | `ls`, `dir`            |
| `New-Item`      | Makes a new directory                            | `mkdir`                |
| `Remove-Item`   | Deletes a file or directory                      | `rm`, `rmdir`          |
| `Get-Location`  | Retrieves path to current directory              | `pwd`                  |
| `Get-Content`   | Returns file contents                            | `cat`, `type`          |
| `Copy-Item`     | Copies a file from one given location to another | `cp`                   |
| `Move-Item`     | Moves a file from one given location to another  | `mv`                   |
| `Write-Output`  | Prints output                                    | `echo`                 |
| `Get-Alias`     | Shows aliases for the current session           | `alias`                |
| `Get-Help`      | Retrieves information about PowerShell commands  | `man`                  |
| `Get-Process`   | Gets processes running on local machine          | `ps`                   |
| `Stop-Process`  | Stops one or more defined process(es)            | `kill`                 |
| `Get-Service`   | Gets a list of services                          | `service --status-all` |

### How to Use Documentation and Find Commands

To find documentation on a cmdlet:

- `Get-Help {cmdlet}`

  - To find documentation on `Set-Location`:

     `Get-Help Set-Location`

To find specific examples:

- `Get-Help {cmdlet} -examples`

To find cmdlets by noun:

- `Get-Command -Type Cmdlet | Sort-Object -Property Noun | Format-Table -GroupBy Noun`

To find cmdlets by verb:

- `Get-Command -Type Cmdlet | Sort-Object -Property Verb | Format-Table -GroupBy Verb`

#### Wildcards

To find by noun:

- `Get-Command -Noun {noun}`

To find by verb:

- `Get-Command -Verb {verb}`
