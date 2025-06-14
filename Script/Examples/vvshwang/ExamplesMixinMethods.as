
// 传送任意Actor到任意位置
// 第一个参数为调用它的任意Actor
mixin void ExampleMixinTeleportActor(AActor Self, FVector Loaction)
{
    Self.ActorLocation = Loaction;
}

void ExampleTeleportActor(AActor Self, FVector Loaction)
{
    Self.ExampleMixinTeleportActor(FVector(Loaction));
}

//在为结构创建混音时，您可以将对结构的引用作为第一个参数。 这允许对其进行更改
mixin void SetVectorToZero(FVector& Vector)
{
    Vector = FVector(0, 0, 0);
}

void Example_StructMixin()
{
    FVector LocalValue;
    LocalValue.SetVectorToZero();
}

// 还可以使用绑定从 C++ 创建 mixin 函数。
// 貌似说为了开放C++函数给脚本用，后面再研究下