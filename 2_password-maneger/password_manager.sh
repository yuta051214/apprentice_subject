#!/bin/bash

echo "パスワードマネージャーへようこそ！"

echo "次の選択肢から入力してください(Add Password/Get Password/Exit)"
read ans

# Add
if [ "$ans" == "Add Password" ]; then
        echo "サービス名を入力してください:"
        read service

        echo "ユーザー名を入力してください:"
        read name

        echo "パスワードを入力してください:"
        read password

        # save
        echo "$service:$name:$password" >> output.txt

        echo "パスワードは保存されました"

# Get
elif [ "$ans" == "Get Password" ]; then
        echo "サービス名を入力してください:"
        read input

        # serch
        output=$(grep "$input" output.txt)

        if [ -z "$output" ]; then
                echo "そのサービスは登録されていません"
        else
                IFS=: read -r service user password <<< "$output"

                echo "サービス名：$service"
                echo "ユーザー名：$user"
                echo "パスワード：$password"
        fi

# Exit
elif [ "$ans" == "Exit" ]; then
        echo "Thank you!"

# Input Error
else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
fi
