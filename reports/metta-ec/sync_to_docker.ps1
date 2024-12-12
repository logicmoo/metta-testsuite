
$containers = @('mettalog', 'hyperon')
$dirs = @('metta-ec', 'metta-pddl')

$hostSrcDirs = $dirs | % { "./" + $_ + "/." }

$mettalogDestDirs = $dirs | % { "/home/user/devspace/" + $_ }
$hyperonDestDirs = $dirs | % { "/home/" + $_ }

function checkContainerRunning ($container) {
    if (-not $(docker ps --filter "name=$container" --filter "status=running" -q)) {
        echo "Container $container has not been started."
        exit 1
    }
}

function doSync($container, $hostSrc, $containerDest) { 
    $folderExists = $(docker exec $container bash -c "[ -d $containerDest ] && echo 'exists'")
    if ($folderExists -eq "exists") {
        docker exec $container bash -c "rm -r $containerDest"
        echo "Deleted $containerDest from $container"
    }
    docker cp $hostSrc ${container}:${containerDest}
}

function doSyncList($container, $srcList, $destList) {
    for ($i = 0; $i -le ($srcList.length - 1); $i += 1) {
        doSync $container $srcList[$i] $destList[$i]
    }
}

foreach ($c in $args) {
    if ($c -in $containers) {
        checkContainerRunning $c
        if ($c -eq "mettalog") {
            doSyncList $c $hostSrcDirs $mettalogDestDirs
        }
        elseif ($c -eq "hyperon") {
            doSyncList $c $hostSrcDirs $hyperonDestDirs
        }
    }
    else {
        echo "Invalid container. Available containers are '${containers}'"
    }
}