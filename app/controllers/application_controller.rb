class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'

  def crawl
    movie_id = params[:id].to_s
    # TODO: 스크립트로 실행할 수 있도록 수정
    # def crawl(movie_id, api_key)

    # TODO: TV 추가, 분기 나누기
    # Movie 있으면 아무것도 안함. 없으면 추가
    movie_res = get_data('movie', movie_id)

    movie = Movie.where(tmdb_id: movie_res['id']).last
    return if movie.present?

    new_movie = Movie.new(
        tmdb_id: movie_res['id'],
        title: movie_res['title'],
        desc: movie_res['overview']
    )
    new_movie.save!

    puts new_movie.title
    # Credit에 person.id 있으므로 일단 Credit부터 가져옴.
    # Movie가 없는데 Credit이 있을수는 없으므로, Credit이 존재하는지는 검사하지 않음.
    credit_res = get_data('credit', movie_id)

    credit_res['cast'].each do |cast|
      person = Person.where(tmdb_id: cast['id']).last

      # Person이 존재하지 않으면 추가해준다.
      if person.blank?
        person_res = get_data('person', cast['id'].to_s)
        person = Person.new(
            tmdb_id: cast['id'],
            name: person_res['name'],
            birthday: person_res['birthday'],
            gender: person_res['gender']
        )
        person.save!
      end

      puts person
      puts person.name

      credit = Credit.new(
          character: cast['character'],
          movie_id: new_movie.id,
          person_id: person.id
      )
      credit.save!
    end

  end

  def get_data(type, id)
    base_url = 'https://api.themoviedb.org/3/'
    api_key = 'api_key=#'

    url_str =
        case type
          when 'movie'  then 'movie/' + id + '?language=ko&'
          when 'person' then 'person/' + id + '?'
          when 'credit' then 'movie/' + id + '/credits?'
        end

    uri = URI(base_url + url_str + api_key)
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  end
end
