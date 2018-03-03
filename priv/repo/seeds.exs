# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CrossSocialMediasApi.Repo.insert!(%CrossSocialMediasApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

CrossSocialMediasApi.Repo.insert(%CrossSocialMediasApi.User{name: "Guillaume", email: "guillaume@domain.com", password: "secret", stooge: "tripleG"})
CrossSocialMediasApi.Repo.insert(%CrossSocialMediasApi.User{name: "Bertrand", email: "bertrand@domain.com", password: "donttell", stooge: "ber"})

CrossSocialMediasApi.Repo.insert(%CrossSocialMediasApi.SocialMediaMapping{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella"})
CrossSocialMediasApi.Repo.insert(%CrossSocialMediasApi.SocialMediaMapping{mapping_name: "Bertrand Dupond", twitter_username: "Ber", instagram_username: "fake_insta"})
CrossSocialMediasApi.Repo.insert(%CrossSocialMediasApi.SocialMediaMapping{mapping_name: "Guillaume Gomez", twitter_username: "zemog_emualluig", instagram_username: "fake_insta2"})