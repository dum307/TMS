# Домашнее задание CI/CD 3

Доработать Multibranch pipeline, разобранный на уроке так, чтобы получаемым docker image, присваивался tag:
- из git tag если он был установлен;
- latest, если git tag не установлен.


В стейдже Prepare добавлена следующая конструкция:

```
try{
    TAG = sh(script: 'git describe --tags --abbrev=0 --exact-match HEAD', returnStdout: true).trim()
} catch(err){
    println ("Tag is empty: ${err.getMessage()}")
    TAG = 'latest'
}
```