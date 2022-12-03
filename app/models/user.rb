class User < ApplicationRecord
    include ActiveModel::SecurePassword
    extend ActiveModel::Translation
    has_secure_password

    validates :login, presence: {message: "не может быть пустым"}, uniqueness: { message: "Пользователь с таким именем уже существует"}
end