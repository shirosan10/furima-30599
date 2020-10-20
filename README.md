# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |
| birthday        | date   | null: false |

<!-- 実装し終えたらyear/month/day事にレコードを分けるかどうか -->

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| user               | references | null: false, foreign_key: true|
| title              | string     | null: false                   |
| catch_copy         | text       | null: false                   |
| genre_id           | integer    | null: false                   |
| status_id          | integer    | null: false                   |
| shipping_fee_id    | integer    | null: false                   |
| prefecture_id      | integer    | null: false                   |
| delivery_date_id   | integer    | null: false                   |
| price              | integer    | null: false                   |

### Association

- has_one :order
- belongs_to :user

## order テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | integer    | null: false, foreign_key: true |
| item_id   | integer    | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## address テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| postal_code             | string     | null: false                    |
| prefecture_id           | integer    | null: false                    |
| city                    | string     | null: false                    |
| line                    | string     | null: false                    |
| building_room           | string     |                                |
| phone_number            | string     | null: false                    |
| order                   | references | null: false, foreign_key: true |

### Association

- belongs_to :order