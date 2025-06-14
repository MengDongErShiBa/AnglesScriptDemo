
/**
 * 演示如何在 AS 中定义一个父类和子类，并在子类中重写父类的方法。
 */
class AAScriptParentActor : AActor
{
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent SceneRoot;

    void PlainMethod(FVector Location)
    {
        Print("PlainMethod called with Location: " + Location.ToString());
    }

    UFUNCTION(BlueprintEvent, Category = "Test")
    void BlueprintEventMethod(int value)
    {
        Print("BlueprintEventMethod called with value: " + value);
    }
}


// 重写示例
class AAScriptChildActor : AAScriptParentActor
{
    // 覆盖父类的默认组件SceneRoot
    // 类似于C++的 ObjectInitializer.SetDefaultSubobjectClass()
    UPROPERTY(OverrideComponent = SceneRoot)
    USceneComponent ChildRootComponent;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        PlainMethod(FVector(100, 200, 300));
        BlueprintEventMethod(42);
    }

    // 所有的函数都可以被重写
    void PlainMethod(FVector Location) override
    {
        Super::PlainMethod(Location);
        Print("Child class PlainMethod called with Location: " + Location.ToString());
        // 可以在这里添加额外的逻辑
    }

   // 重写父类的BlueprintEvent函数，需要使用BlueprintOverride
   // 这里先不测试，遇到再说
   // 当重写 C++BlueprintNativeEvent 时，由于技术限制，无法调用 C++ Super 方法。
   // 您可以选择创建 BlueprintImplementableEvent，或者将基本实现放在单独的可调用函数中。
   UFUNCTION(BlueprintOverride, Category = "Test")
   void BlueprintEventMethod(int value)
   {
        Super::BlueprintEventMethod(value);
        Print("Child class BlueprintEventMethod override called with value: " + value);
   }
}