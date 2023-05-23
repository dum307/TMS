def call(flag, apps, parallel_count, built_apps = [:]) {
    stageList = []
    stageMap = [:]
    apps.eachWithIndex { app, path, i ->
        Integer lock_id = i % parallel_count
        if (flag == 'build') {
            stageMap.put(app, stageBuildCreate(app, path, lock_id, built_apps))
        } else if (flag == 'image') {
            stageMap.put(app, stageImageCreate(app, path, lock_id))
        } 
        else if (flag == 'deploy') {
            stageMap.put(app, stageImageDeploy(app, path, lock_id))
        } 
    }
    stageList.add(stageMap)
    return stageList
}