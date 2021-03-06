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

alias CrossSocialMediasApi.{Repo, User, SocialMediaMapping}
Repo.insert(User.registration_changeset(%User{}, %{name: "Guillaume", email: "guillaume@domain.com", password: "secret", username: "tripleG"}))
Repo.insert(User.registration_changeset(%User{}, %{name: "Bertrand", email: "bertrand@domain.com", password: "donttell", username: "ber"}))
{:ok, user_demo} = Repo.insert(User.registration_changeset(%User{}, %{name: "Demo", email: "demo@admin.com", password: "adminadmin", username: "demo"}))

Repo.insert(%SocialMediaMapping{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "UCrurr3qbH0VFCwaoIvXOn-Q", user_id: user_demo.id})
Repo.insert(%SocialMediaMapping{mapping_name: "Bertrand Dupond", twitter_username: "dupont_bertrand", instagram_username: "fake_insta", youtube_channel_id: "123456", user_id: user_demo.id})
Repo.insert(%SocialMediaMapping{mapping_name: "Guillaume Gomez", twitter_username: "zemog_emualliug", instagram_username: "fake_insta2", youtube_channel_id: "123456", user_id: user_demo.id})
