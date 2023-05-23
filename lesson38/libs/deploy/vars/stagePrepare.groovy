def call(apps, parallel_count) {
    stageList = []
    stageMap = [:]
    apps.eachWithIndex { app, path, i ->
        Integer lock_id = i % parallel_count
        stageMap.put(app, stageImageDeploy(app, path, lock_id))
    }
    stageList.add(stageMap)
    return stageList
}