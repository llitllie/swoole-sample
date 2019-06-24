<?php
$http = new swoole_http_server("0.0.0.0", 9501);

$http->on("start", function ($server) {
    echo "Swoole http server is started at http://0.0.0.0:9501\n";
});

$http->on("request", function ($request, $response) {
    $data = route($request, $response);
});
function route($request, $response){
    $response->header("Content-Type", "text/plain");
    $uri=$request->server['request_uri'];
    switch($uri){
        case "/test":
            $data = test($request);
            break;
        case "/":
            $data = index($request);
            break;
        default:
            $data = '404';
    }
    $response->end($data);
}
function index($request){
    return "Hello world!\n";
}
function test($request){
    $data = json_encode($request);
    return $data;
}

$http->start();
