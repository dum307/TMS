def call(app, path, lock_id) {
    return {
        stage(app) {
            lock("Image-deploy-lock-${lock_id}") {
                    sh """
                        docker run --rm --name ${app} ${DOCKER_REGISTRY}/${app}:${env.TAG}
                    """
            }
        }
    }
}