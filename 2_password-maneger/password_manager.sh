#!/bin/bash

echo "パスワードマネージャーへようこそ！"

echo "次の選択肢から入力してください(Add Password/Get Password/Exit)"
read ans

if [ "$ans" == "Add Password" ]; then
        echo "サービス名を入力してください:"
        read service

        echo "ユーザー名を入力してください:"
        read name

        echo "パスワードを入力してください:"
        read password

        echo "$service:$name:$password" >> output.txt

        echo "パスワードは保存されました"
elif [ "$ans" == "Get Password" ]; then
        echo "サービス名を入力してください:"
        read input

        output=$(grep "$service" output.txt)
        IFS=: read -r service user password <<< "$output"

        echo "サービス名：$service"
        echo "ユーザー名：$user"
        echo "パスワード：$password"
elif [ "$ans" == "Exit" ]; then
        echo "Thank you!"
else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
fi
