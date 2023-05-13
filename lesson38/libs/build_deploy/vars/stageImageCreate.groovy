def call(app, path, lock_id) {
    return {
        stage(app) {
            lock("Image-create-lock-${lock_id}") {
                dir (path) {
                    sh "docker build -t ${DOCKER_REGISTRY}/${app}:${env.TAG} -f Dockerfile-create ."
                }
            }
        }
    }
}