const FGameplayTag TheTag = GameplayTags::EnhancedInput;

#if EDITOR
    // 编辑器模式
#endif

#if EDITORONLY_DATA
    // 编辑器数据
#endif

// 其他宏 EDITORONLY_DATARELEASETEST RELEASE TEST

// 可以在包中跳过的文件夹
// Editor, Examples, Dev, 编辑器，示例，开发

// 模拟cooked来排查问题
// -as-simulate-cooked

// UnrealEditor-Cmd.exe "MyProject.uproject" -as-simulate-cooked -run=AngelscriptTest