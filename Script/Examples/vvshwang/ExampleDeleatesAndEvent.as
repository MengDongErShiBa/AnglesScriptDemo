// 声明一个委托 等价于C++中的 DESIGNE_DYNAMIC_DELEGATE,绑定到委托的函数必须声明为UFUNCITON()
delegate void FExampleDelegate();
delegate void FExampleDelegateTwoParams(UObject Object, float Value);

class ANameLiteralActor : AActor
{
    TMap<FName, int> ValuesByName;

    void UseNameLiteral()
    {
        FName NameVariable = n"MyName";
        ValuesByName.Add(NameVariable, 1);

        FExampleDelegate Delegate;
        Delegate.BindUFunction(this, n"FunctionBoundToDelegate");
        Delegate.ExecuteIfBound();

        // Due to the name literal, no string manipulation happens
        // in calls to UseNameLiteral() during runtime.
    }

    UFUNCTION()
    void FunctionBoundToDelegate()
    {
        Print("Delegate executed");
    }
}

class AExampleDeleatesAndEvent : AActor
{
    FExampleDelegateTwoParams DelegateTwoParams;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        // 绑定委托
        DelegateTwoParams.BindUFunction(this, n"FunctionBoundToDelegateTwoParams");

        // 使用委托构造绑定
        DelegateTwoParams = FExampleDelegateTwoParams(this, n"FunctionBoundToDelegateTwoParams");
    }

    UFUNCTION()
    void FunctionBoundToDelegateTwoParams(UObject Object, float Value)
    {
        Print("DelegateTwoParams executed");
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        if (DelegateTwoParams.IsBound())
        {
            DelegateTwoParams.ExecuteIfBound(this, 1.0f);
        }
    }
}

// 声明一个多播委托，等价于C++ 中的DECLARE_MULTICAST_DELEGATE，必须绑定UFUNCTION()
event void FExampleEvent(int Counter);

class AEventExample : AActor
{
    UPROPERTY()
    FExampleEvent OnExampleEvent;

    private int CallCounter = 0;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        // Add two functions to be called when the event is broadcast
        OnExampleEvent.AddUFunction(this, n"FirstHandler");
        OnExampleEvent.AddUFunction(this, n"SecondHandler");
    }

    UFUNCTION()
    private void FirstHandler(int Counter)
    {
        Print("Called first handler");
    }

    UFUNCTION()
    private void SecondHandler(int Counter)
    {
        Print("Called second handler");
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        CallCounter += 1;
        OnExampleEvent.Broadcast(CallCounter);
    }
}