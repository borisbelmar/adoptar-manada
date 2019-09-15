<?php
    //adopta.elpoderdelamanada.org
    $array = [["id"=>1, "name"=>"Doggo"], ["id"=>2, "name"=>"Loco"], ["id"=>3, "name"=>"Huba"]];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <table>
        <thead>
            <th>ID</th>
            <th>Name</th>
        </thead>
        <tbody>
            <?php foreach($array as $item): ?>
            <tr>
                <td><?php echo $item['id'] ?></td>
                <td><?php echo $item['name'] ?></td>
            </tr>
            <?php endforeach ?>
        </tbody>
    </table>
</body>
</html>