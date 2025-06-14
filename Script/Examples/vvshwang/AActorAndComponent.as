class AExamplesActor : AActor
{
    
    // DefaultComponent CreateDefaultSubobject
    // RootComponent SetRootComponent
    // 如果没有指定RootComponent，那么默认创建的第一个Component就是RootComponent
    UPROPERTY(DefaultComponent, RootComponent)
    USceneComponent SceneComponent;

    // 默认附加到SceneRoot，因为没有指定附加到哪个Component
    UPROPERTY(DefaultComponent)
    USkeletalMeshComponent CharacterMesh;

    // 指定相对位置,设置默认值
    default CharacterMesh.RelativeLocation = FVector(0, 0, 50);


    // 指定附加到CharacterMesh，指定Socket为RightHand
    UPROPERTY(DefaultComponent, Attach = CharacterMesh, AttachSocket = RightHand)
    UStaticMeshComponent WeaponMesh;

    // 指定附加到WeaponMesh，指定Socket为LeftHand
    UPROPERTY(DefaultComponent, Attach = CharacterMesh, AttachSocket = LeftHand)
    UStaticMeshComponent SheildMesh;
    // 盾牌默认隐藏
    default SheildMesh.bHiddenInGame = true;
    // 盾牌默认没有碰撞
    default SheildMesh.SetCollisionEnabled(ECollisionEnabled::NoCollision);

    // 定义一个Component
    UPROPERTY(DefaultComponent)
    UMyComponent MyComponent;

    TSubclassOf<AActor> ActorClass;

    // 重写蓝图构造脚本
    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        Log("ConstructionScript Test");
        int SpawnActor = 5;

        for (int i = 0; i < SpawnActor; i++)
        {
            UStaticMeshComponent MeshComponent = UStaticMeshComponent::Create(this);
        }

    }


    // 查询或创建
    void ExamplesGetAndCreate(AActor Actor, ACharacter Character)
    {
        // 在Actor上找到的第一个骨骼网格组件
        USkeletalMeshComponent SkelComp = USkeletalMeshComponent::Get(Actor);
        // 查找具有此名称的特定骨骼网格组件
        USkeletalMeshComponent WeaponComp = USkeletalMeshComponent::Get(Actor, n"WeaponMesh");

        // 查找或创建一个MyComponent
        UMyComponent InteractComp = UMyComponent::GetOrCreate(Actor);
        // 查找或创建一个指定名称的MyComponent
        auto Inte0ractComp2 = UMyComponent::GetOrCreate(Actor, n"InteractComp");

        // 在角色上创建一个新的MyComponent
        UStaticMeshComponent StaticMeshComponent = UStaticMeshComponent::Create(Character);
        StaticMeshComponent.AttachToComponent(Character.Mesh);

        /**
         *  If you have a dynamic TSubclassOf<> or UClass for a component class,
         *  you can also use the generic functions on actors 
         *  for these operations by using Actor.GetComponent(),
         *  Actor.GetOrCreateComponent(), 
         *  or Actor.CreateComponent()
         *  // 如果你有TSubclassOf<>或UClass的组件类，
         *  可以使用Actor.GetComponent()，Actor.GetOrCreateComponent()，或Actor.CreateComponent()
         */
        
        // 查询Actor上所有的UStaticMeshComponent
        // 根据传入的Array类型查询身上的组件
        TArray<UStaticMeshComponent> StaticMeshComponents;
        Actor.GetComponentsByClass(StaticMeshComponents);

        for (UStaticMeshComponent MeshComp : StaticMeshComponents)
        {
            Print(f"Static Mesh Component: {MeshComp.Name}");
        }

        // 获取世界中特定类型所有Actor,使用去全局Global函数
        TArray<AActor> Actors;
        GetAllActorsOfClass(Actors);
    }

    // 生成Actor
    void ExamplesSpawningActors()
    {
        // 在指定位置创建一个SpawnActor
        FVector SpawnLoaction = FVector(0, 0, 0);
        FRotator SpawnRotation = FRotator(0, 0, 0);
        AExamplesActor SpawnedActor = SpawnActor(AExamplesActor,SpawnLoaction, SpawnRotation);

        // 通过TSubclassOf<>创建一个SpawnActor
        AActor SpawnedActor2 = SpawnActor(ActorClass, SpawnLoaction, SpawnRotation);
    }
}



// UCLASS 并不是必须得，默认是UClass
UCLASS()
class UMyComponent : UActorComponent
{
    // 定义一个Component
}