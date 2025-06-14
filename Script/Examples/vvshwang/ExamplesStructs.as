struct FExamplesStructs
{
    // 蓝图可见
    UPROPERTY()
    float ExampleNumber = 4.0;

    UPROPERTY()
    FString ExampleString = "Hello World!";

    // 蓝图不可见，但是脚本中可以访问
    float ExampleHiddenNumber = 10.0;

    // 另外，结构不允许继承，不允许写UFUNCTION，但是可以写纯脚本函数
}

// 结构体可以在UFUNCTION中正常传递
UFUNCTION(BlueprintPure)
bool IsNumberInStructEqual(FExamplesStructs Struct, float TestNumber)
{
    return Struct.ExampleNumber == TestNumber;
}

// 默认情况下，脚本函数中的参数值是只读的。这意味着不能更改结构参数的属性，也不能对其调用非 const 方法。
// 可以引用一个结构来修改
UFUNCTION()
void RandomizeNumberInStruct(FExamplesStructs& Struct)
{
    Struct.ExampleNumber = Math::RandRange(0.0, 1.0);
}

// 可以再蓝图中输出两个引脚
UFUNCTION()
void OutputRandomizedStruct(FExamplesStructs&out OutputStruct, bool&out bOutSuccessful)
{
    FExamplesStructs ResultStruct;
    ResultStruct.ExampleNumber = Math::RandRange(0.0, 1.0);

    OutputStruct = ResultStruct;
    bOutSuccessful = true;
}

// NOTE:作为实现细节：脚本函数从不按值接受结构参数。
// 当你声明一个结构参数时，它在内部被实现为一个常量引用，就像你添加了。const&
// 这意味着参数和参数之间没有区别。两者在性能和语义上完全相同。FVector const FVector&
// 这个选择是为了提高脚本性能，避免必须指示游戏脚本编写人员编写所有参数。const&