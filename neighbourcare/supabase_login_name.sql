-- Run this once in the Supabase SQL editor for the neighbourcare project,
-- after supabase_forum_replies.sql.
--
-- Adds a public "login name" that new users choose at sign-up, shown in
-- the top banner instead of their email, and stamped onto each reply so
-- other users can see who wrote it.

alter table public.users
  add column if not exists login_name text;

-- Case-insensitive uniqueness: allows any number of NULLs (existing rows
-- that haven't set one yet), but blocks two accounts from taking the same
-- name.
create unique index if not exists users_login_name_unique_idx
  on public.users (lower(login_name))
  where login_name is not null;

-- Denormalized so the reply feed doesn't need a join/lookup per reply.
alter table public.forum_replies
  add column if not exists author_login_name text;
