# Lotus

The Lotus gem wasn't released yet, but all
[the](https://github.com/lotus/router)
[core](https://github.com/lotus/controller)
[frameworks](https://github.com/lotus/view) are out at the version 0.1.0.  This
is a sample application that uses all available Lotus components. It is based
on @jodosha's [example](https://gist.github.com/jodosha/9830002).

# The Application

The application is a system for booking conference rooms in a coworing space.
Users can pick a free slot to book a room, and an administrator can manage
rooms and see reports on how much a team has used a room.

# Status

- [x] Index/Create Rooms
- [ ] Show validation errors on create
- [ ] Updating rooms
- [ ] Deleting rooms
- [ ] Implement Teams CRUD
- [ ] Implement authorization for teams
- [ ] Implement authorization for admins
- [ ] Allow teams to book a room at a specific time
- [ ] Allow admins to see room usage by teams

# Setup

1. Clone repo
2. Run `bundle install`
3. Migrate the database ``sequel -m db/migrations `dotenv 'echo $DATABASE_URL'` ``
4. Start the server with `rake server`
