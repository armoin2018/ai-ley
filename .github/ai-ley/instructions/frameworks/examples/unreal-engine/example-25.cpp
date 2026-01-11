// Custom plugin module
class FMyGamePluginModule : public IModuleInterface
{
public:
    virtual void StartupModule() override;
    virtual void ShutdownModule() override;

    static inline FMyGamePluginModule& Get()
    {
        return FModuleManager::LoadModuleChecked<FMyGamePluginModule>("MyGamePlugin");
    }
};