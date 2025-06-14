class ATimer : AActor
{
    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        Print("Timer BeginPlay called");
        System::SetTimer(this, n"OnTimerExecuted", 1.0f, true);
    }

    UFUNCTION(BlueprintCallable)
    void OnTimerExecuted()
    {
        Print("OnTimerExecuted called");
    }
}

/**
 * 
 *  Math:: - All standard math functionality 所有 数学功能
    Gameplay:: - Game functionality such as streaming, damage, player handling 游戏功能，如流，伤害，玩家处理
    System:: - Engine functionality such as timers, traces, debug rendering 引擎功能，如计时器，跟踪，调试渲染
    Niagara:: - Spawning and controlling particle systems  创建和控制粒子系统
    Widget:: - UMG widget functionality UMG小部件功能

    // AS中的访问方式
    UNiagaraFunctionLibrary becomes Niagara::
    UWidgetBlueprintLibrary becomes Widget::
    UKismetSystemLibrary becomes System::
    UGameplayStatics becomes Gameplay::
 */

