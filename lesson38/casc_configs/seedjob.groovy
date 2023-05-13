
folder('build') {
    description('<div style="border-radius:10px; text-align: center; font-size:120%; padding:15px; background-color: powderblue;">Simple app CI</div>')
}

multibranchPipelineJob('build/ci') {
    branchSources {
        branchSource {
            source {
                github {
                    // Specify the name of the GitHub Organization or GitHub User Account.
                    repoOwner('dum307')
                    // The repository to scan.
                    repository('TMS')
                    // Specify the HTTPS URL of the GitHub Organization / User Account and repository.
                    repositoryUrl('https://github.com/dum307/TMS.git')
                    configuredByUrl(true)
                    // Credentials used to scan branches and pull requests, check out sources and mark commit statuses.
                    credentialsId('github-http')
                    traits {
                        gitHubBranchDiscovery {
                            strategyId(3)
                        }
                        gitHubPullRequestDiscovery {
                            strategyId(1)
                        }
                        headWildcardFilter {
                            includes('main PR-*')
                            excludes('')
                        }
                    }
                }
            }
        }
    }
  	factory {
    	workflowBranchProjectFactory {
          	scriptPath('lesson38/Jenkinsfile-multi')
        }
    }
  	properties {
        folderLibraries {
            libraries {
                libraryConfiguration {
                    name('general')
                    retriever {
                        modernSCM {
                            scm {
                                git {
                                    remote('https://github.com/dum307/TMS.git')
                                    credentialsId('github-http')
                                }
                                libraryPath('lesson38/libs/general')
                            }
                        }
                        // If checked, scripts may select a custom version of the library by appending @someversion in the @Library annotation.
                        allowVersionOverride(true)
                        // A default version of the library to load if a script does not select another.
                        defaultVersion('main')
                    }
                }
                libraryConfiguration {
                    name('build')
                    retriever {
                        modernSCM {
                            scm {
                                git {
                                    remote('https://github.com/dum307/TMS.git')
                                    credentialsId('github-http')
                                }
                                libraryPath('lesson38/libs/build')
                            }
                        }
                        // If checked, scripts may select a custom version of the library by appending @someversion in the @Library annotation.
                        allowVersionOverride(true)
                        // A default version of the library to load if a script does not select another.
                        defaultVersion('main')
                    }
                }
	        }
	    }
    }
}