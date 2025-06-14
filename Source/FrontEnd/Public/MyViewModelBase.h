#pragma once
#include "INotifyFieldValueChanged.h"
#include "MVVMViewModelBase.h"
#include "MyViewModelBase.generated.h"

UCLASS(Blueprintable)
class UMyViewModelBase : public UMVVMViewModelBase
{
	GENERATED_BODY()

private:
	// FieldNotify：使得属性可以用于通知广播
	// Setter:此属性可以被设置，Setter函数的名称格式 Set[Variable Name],CurrentHealth的Setter为：SetCurrentHealth
	// Setter = [Function Name] 也可以自己指定名称，写法如前
	// Getter:此属性可以被获取，Getter函数的名称格式为 Get[Variable Name],CurrentHealth的Getter为：GetCurrentHealth
	// Getter = [Function Name] 也可以自己指定名称，写法如前
	// 此字段在ViewModel中使用Get/Set访问，在蓝图中是Public的，在蓝图中ViewBanding使用Get/Set
	UPROPERTY(BlueprintReadWrite, FieldNotify, Setter, Getter, meta=(AllowPrivateAccess))
	int32 CurrentHealth;
		
	UPROPERTY(BlueprintReadWrite, FieldNotify, Setter, Getter, meta=(AllowPrivateAccess))
	int32 MaxHealth;
 
public:
	void SetCurrentHealth(int32 NewCurrentHealth)
	{
		if (UE_MVVM_SET_PROPERTY_VALUE(CurrentHealth, NewCurrentHealth))
		{
			UE_MVVM_BROADCAST_FIELD_VALUE_CHANGED(GetHealthPercent);
		}
	}
 
	void SetMaxHealth(int32 NewMaxHealth)
	{
		// 有特化模版，最终作用是做compare和触发Boradcast
		if (UE_MVVM_SET_PROPERTY_VALUE(MaxHealth, NewMaxHealth))
		{
			// 如果MaxHealth改变了，HealthPercent也需要更新
			// 内部通过名称拿到一个FieldId，然后通过FieldId找到对应的Delegate
			UE_MVVM_BROADCAST_FIELD_VALUE_CHANGED(GetHealthPercent);
		}
 
	}
 
	int32 GetCurrentHealth() const
	{
		return CurrentHealth;
	}
 
	int32 GetMaxHealth() const
	{
		return MaxHealth;
	}
 
public:
	/**
	 * 必须具有带 FieldNotify 和 BlueprintPure 说明符的 UFUNCTION 宏。
	 * 不得带有参数。
	 * 必须是 const 函数。
	 * 必须仅返回单个值（没有输出参数）。
	 * @return 
	 */
	UFUNCTION(BlueprintPure, FieldNotify)
	float GetHealthPercent() const
	{
		if (MaxHealth != 0)
		{
			return (float) CurrentHealth / (float) MaxHealth;
		}
		else
			return 0;
	}
};
