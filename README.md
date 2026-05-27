# logwatch — Log Analyzer

A terminal-based log analysis tool written in Bash.

> 🔧 Part of the [cloud-learning](../sysmon) project series.

---

## Usage

```bash
./logwatch.sh                          # analyze default system log
./logwatch.sh --file <path>            # analyze specific log file
./logwatch.sh --level <ERROR|WARN|INFO> # filter by log level
./logwatch.sh --summary                # show statistics summary
./logwatch.sh --help                   # show usage
# Search for specific keyword
./logwatch.sh --file /var/log/wifi.log --grep "timeout"
./logwatch.sh --file /var/log/wifi.log --grep "connection"
```
## Usage Example

```bash
# Analyze system wifi log
./logwatch.sh --file /var/log/wifi.log

# Show only errors from a specific log
./logwatch.sh --file /var/log/system.log --level ERROR

# Show summary of any log file
./logwatch.sh --file /var/log/install.log --summary
```
---

## Features

- Analyzes any log file by path — works system-wide
- Filters log entries by level (ERROR, WARN, INFO)
- Summary statistics — total lines, error/warn/info counts
- Color-coded output — red errors, yellow warnings, green info
- Error handling — validates file existence before processing
- Keyword search — find any word or phrase across the entire log file

---

## Example output
```
📊 LOGWATCH — wifi.log
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total lines: 1042
ERROR:  12
WARN:   38
INFO:   156
```
---

## Technologies
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)