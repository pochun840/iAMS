<?php require APPROOT . 'views/inc/header.tpl'; ?>

<link rel="stylesheet" href="<?php echo URLROOT; ?>css/w3.css" type="text/css">
<link rel="stylesheet" href="<?php echo URLROOT; ?>css/login.css" type="text/css">
<link href='<?php echo URLROOT; ?>css/boxicons.min.css' rel='stylesheet'>

    <div class="container">
        <header>
            <h2>Kilews</h2>
            <h4>登入</h4>
        </header>
        <form action="?url=Logins" method="POST">
            <div class="input-field">
                <input type="text"  name="username" required>
                <label>Username</label>
            </div>
            <div class="input-field">
                <input class="pswrd" name="password" type="password" required>
                <label>Password</label>
            </div>
            <div class="button">
                <div class="inner">
				</div>
                <button type="submit"><?php echo $text['login_text']; ?></button>
            </div>
        </form>

        <!--  Change Language -->
        <div id="language-selector" class="w3-padding w3-display-botom">
            <label style="font-size: 16px; color: #fff" for="language">Select Language :</label>&nbsp;
            <select class="custom-select" id="language" onchange="changeLanguage()">
                <option value="zh-cn">简中</option>
                <option value="zh-tw">繁中</option>
                <option value="en-us">English</option>
                <option value="vi">Tiếng Việt</option>
            </select>
        </div>
    </div>

  <script>
    function language_change(language) {
        $.ajax({
          type: "POST",
          url: "?url=Dashboards/change_language",
          data: {'language':language},
          dataType: "json",
          encode: true,
          async: false,//等待ajax完成
        }).done(function (data) {//成功且有回傳值才會執行
            window.location = window.location.href;
        });
    }

    $(document).ready(function () {
        <?php
            if(isset($data['error_message'])){
                if($data['error_message'] != ''){
                    echo "alert('",$data['error_message'],"')";
                }
            }
        ?>
    });

// Change Language .......
function changeLanguage()
{
    var selectedLanguage = document.getElementById("language").value;

    var elements = document.querySelectorAll("[data-zh], [data-en], [data-vi]");

    elements.forEach(function(element) {
        switch (selectedLanguage) {
            case "zh":
                element.textContent = element.getAttribute("data-zh");
                break;
            case "en":
                element.textContent = element.getAttribute("data-en");
                break;
            case "vi":
                element.textContent = element.getAttribute("data-vi");
                break;
            default:
                element.textContent = element.getAttribute("data-en");
                break;
        }
    });
}


  </script>

<?php require APPROOT . 'views/inc/footer.tpl'; ?>