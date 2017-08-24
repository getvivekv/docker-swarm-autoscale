<?php

include 'Swarm.php';

$swarm = new Swarm();

$url = 'http://influxdb:8086/query?pretty=true';

$interval = 1; // 5 minutes

$data = array(
    'db' => 'cadvisor',
    'q' => "SELECT * FROM cpu_usage_total WHERE service='us-uat-soss' AND time > now() - " .$interval . "m"
);


$return = $swarm->curlContents($url, 'POST', $data);
$json = json_decode($return, true);
echo '<pre>';
print_r($json);

exit ;

$values = $json['results'][0]['series'][0]['values'];
//print_r($values);

foreach ($values as $key => $value) {
    $serviceName = $value[3];
    $containerId = $value[1];
    $cpuLoad = $value[4];
    $services[$serviceName][$containerId] += $cpuLoad;

    $replicas[$serviceName] = count($services[$serviceName]);
}
print_r($services);

foreach($services as $serviceName => $containerInfo){
    foreach($containerInfo as $containerId => $cpuLoad) {
        $services[$serviceName][$containerId] = $cpuLoad / ($interval * 2);
    }
}

print_r($services);


