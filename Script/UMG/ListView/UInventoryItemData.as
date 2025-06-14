class UInventoryItemData : UObject
{
    // 向蓝图公开, AS中默认为EditorAnyWhere
    // Category和C++侧一样用法
    // BlueprintReadOnly:该属性可以在蓝图中使用`Get`节点，但不能使用`Set`节点
    // BlueprintHidden:根本无法访问此属性
    // EditDefaultsOnly:只能从蓝图中的默认值编辑，不能在级别中的实例上编辑
    // EditInstanceOnly:只能在级别中的实例上编辑，不能在蓝图默认值中编辑
    // VisibleAnywhere: 可以从任何地方的属性详细信息中看到值，但无法更改
    // NotEditable: 该属性在任何位置都不可编辑
    // Instanced: 该属性是一个实例化的对象，可以在蓝图中编辑
    UPROPERTY(Instanced, ExposeOnSpawn)
    FText Content;

    UPROPERTY(Instanced)
    bool bIsSelected;
    default bIsSelected = false;

    // 修饰符，和C++侧一样，不过需要每个指定，默认是Public
    FText GetConent() const property
    {
        return Content;
    }

    void SetContent(FText NewContent)
    {
        Content = NewContent;
    }

    bool GetIsSelected()
    {
        return bIsSelected;
    }

    void SetIsSelected(bool bNewIsSelected)
    {
        bIsSelected = bNewIsSelected;
    }
}

class UTest : UMVVMViewModelBase
{
    UPROPERTY(EditAnywhere)
    float Test;
    UPROPERTY()
    float Test2;
}