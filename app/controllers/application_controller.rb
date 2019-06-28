class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'

  def crawl
    movie_id = params[:id].to_s
    # TODO: 스크립트로 실행할 수 있도록 수정
    # def crawl(movie_id, api_key)

    # TODO: TV 추가, 분기 나누기
    movie_res = get_data('movie', movie_id)

    # Movie 있으면 아무것도 안함. 없으면 추가
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

  def crawl_tv
    # TV API Call
    tv_id = params[:id]
    puts tv_res['name']
    puts tv_res['id']

    # Episode가 존재하는지 확인
    # Episode가 있으면 Season, Tv도 존재하므로 아무것도 하지 않음.
    # Episode가 없는 경우
    #   새 Episode를 생성하고 저장
    #   Season API Call, Season 존재여부 확인
    #   Season 있으면 리턴
    #   없으면 Season 저장하고 TV API Call
    tv_res = get_data('tv', tv_id)
    #   TV 없으면 저장
    tv = Tv.where(tmdb_id: tv_res['id']).last
    tv_season = TvSeason.where(tv_id: tv.id).last
    if !tv.present?
      new_tv = Tv.new(
          tmdb_id: tv_res['id'],
          name: tv_res['name']
      )
      new_tv.save!
      puts new_tv.name

      tv_res['seasons'].each do |season|

      end
    end


  end

  def get_data(type, id)
    base_url = 'https://api.themoviedb.org/3/'
    api_key = 'api_key=#'

    url_str =
        case type
          when 'movie'  then 'movie/' + id + '?language=ko&'
          when 'tv'  then 'tv/' + id + '?language=ko&'
          when 'person' then 'person/' + id + '?'
          when 'credit' then 'movie/' + id + '/credits?'
        end

    uri = URI(base_url + url_str + api_key)
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  end
end
