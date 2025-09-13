class Hobby < ActiveHash::Base
  self.data = [
      {id: 1, name: 'ゲーム'}, {id: 2, name: 'アニメ・ドラマ'}, {id: 3, name: 'スポーツ'},
      {id: 4, name: '読書'}, {id: 5, name: '運動'}, {id: 6, name: '旅行'}
  ]

  include ActiveHash::Associations
  has_many :users
end