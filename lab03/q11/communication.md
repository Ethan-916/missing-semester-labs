### 1. Issue
**标题**: [Bug] 传入纯空白字符姓名时未做校验且异常退出码不正确
- **环境**: Windows (具体版本待确认)
- **复现命令**: `sdt-greet --name " "`
- **实际结果**: 输出 `Hello,  !` 且退出码为 0
- **期望结果**: 拦截纯空白参数，以退出码 2 终止运行并提示参数无效

### 2. 提交信息
Reject whitespace-only names with exit code 2

CLI previously allowed whitespace-only strings for `--name`, outputting an empty greeting and returning exit code 0.
Add a validation check using `strip()` after argument parsing to trigger `sys.exit(2)` on blank names.

### 3. 评审意见
[Blocking] 当前实现仅用 `argparse` 验证了参数存在，但未过滤纯空格输入（如 `sdt-greet --name " "`），导致程序打印无效问候并以 0 正常退出。这会破坏下游脚本的异常校验流程。建议在解析后使用 `not name.strip()` 进行非空校验，并在命中时调用 `sys.exit(2)` 终止。
