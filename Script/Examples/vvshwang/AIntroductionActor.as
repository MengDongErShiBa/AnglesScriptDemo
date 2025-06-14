
/**
 * 演示继承关系
 */

class AIntroductionActor : AActor
{
    UPROPERTY()
    float CountdownDuration = 5.0;

    float CurrentTimer = 0.0;
    bool bCountdownActive = false;

    // DefaultComponent 和 Attach 属性用于设置组件的默认值和附加关系
    // DefaultComponent等价于构造函数中的 CreateDefaultSubobject
    // RootComponent 用于指定该组件为根组件
    // RootComponent等价于构造函数中的SetRootComponent
    // 如果没有指定RootComponent，那么第一个创建的组件将成为根组件
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent SceneRoot;

    // Attach 属性用于将 Mesh 组件附加到 SceneRoot
    // 如果没有指定，将默认附加到SceneRoot因为没有手动指定组件
    // AttachSocket = RightHand 等价于 附加到 SceneRoot 的 RightHand Socket
    UPROPERTY(DefaultComponent, Attach = SceneRoot)
    UStaticMeshComponent Mesh;

    UPROPERTY(DefaultComponent, Attach = SceneRoot)
    UBillboardComponent Billboard;

    // BlueprintOverride 可以覆盖常见事件，应该也可以覆盖C++侧自定义的函数
    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        {
            // Case 1: Start a countdown timer
            // Start the countdown on beginplay with the configured duration
            // CurrentTimer = CountdownDuration;
            // bCountdownActive = true;
        }
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        {
            // Case 1: Update the countdown timer
            // if (bCountdownActive)
            // {
            //     CurrentTimer -= DeltaSeconds;

            //     if (CurrentTimer <= 0)
            //     {
            //         Print("Countdown was completed!");
            //         bCountdownActive = false;
            //     }
            // }
        }

        {
            // Case 2: Update the countdown timer
            if (bCountdownActive)
            {
                CurrentTimer -= DeltaSeconds;

                if (CurrentTimer <= 0)
                {
                    // The countdown was completed
                    Print("Countdown was completed!");
                    FinishedCountdown();
                    bCountdownActive = false;
                }
            }
        }

    
    }

    // UFUNCTIONs are used to expose functions to Blueprints
    UFUNCTION()
    void StartCountdown()
    {
        // Case 2: Start a countdown timer
        // Start the countdown when StartCountdown() is called
        CurrentTimer = CountdownDuration;
        bCountdownActive = true;
        Print("Countdown started!");
    }

    UFUNCTION(BlueprintEvent)
    void FinishedCountdown()
    {
        // 只有在蓝图没有覆写的情况下才会调用
        Print("This waill only print if not overridden in Blueprint!");
        // This function can be overridden in Blueprints to handle countdown completion
        Print("Countdown finished!");
    }
}

// 这种处于全局作用域的函数，可以像蓝图函数库一样从任意蓝图调用
UFUNCTION()
void ExampleGlobalFunctionMoveActor(AActor Actor, FVector NewLocation)
{
    // This is a global function that can be called from anywhere
    if (Actor != nullptr)
    {
        Actor.SetActorLocation(NewLocation);
        Print("Moved actor to new location: " + NewLocation.ToString());
    }
    else
    {
        Print("Actor is null, cannot move.");
    }
}