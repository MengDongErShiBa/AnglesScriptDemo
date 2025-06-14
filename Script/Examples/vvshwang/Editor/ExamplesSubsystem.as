
void ExampleGetSubsystem()
{
    // 获取子系统
    // 只有在Editor文件夹下生效，因为是编辑器子系统
    auto LevelEditorSubsystem = ULevelEditorSubsystem::Get();
}

// 如何创建子系统
class UMyGameWorldSubsystem : UScriptWorldSubsystem
{
    UFUNCTION(BlueprintOverride)
    void Initialize()
    {
        Print("MyGame World Subsystem Initialized!");
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaTime)
    {
        Print("Tick");
    }

    // Create functions on the subsystem to expose functionality
    UFUNCTION()
    void LookAtMyActor(AActor Actor)
    {
    }
}

void UseMyGameWorldSubsystem()
{
    auto MySubsystem = UMyGameWorldSubsystem::Get();
    MySubsystem.LookAtMyActor(nullptr);
}

class UMyPlayerSubsystem : UScriptLocalPlayerSubsystem
{
}

void UseScriptedPlayerSubsystem()
{
    // 脚本中获取子系统
    ULocalPlayer RelevantPlayer = Gameplay::GetPlayerController(0).LocalPlayer;
    auto MySubsystem = UMyPlayerSubsystem::Get(RelevantPlayer);
}

// 子系统类型
/**
    UScriptWorldSubsystem for world subsystems
    UScriptGameInstanceSubsystem for game instance subsystems
    UScriptLocalPlayerSubsystem for local player subsystems
    UScriptEditorSubsystem for editor subsystems
    UScriptEngineSubsystem for engine subsystems
 */

 // 蓝图中可以直接用MyGameWorldSubsystem来获取