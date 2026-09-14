-- Run this once in the Supabase SQL editor for the neighbourcare project.
-- Adds the table backing the new "reply to a post" feature on
-- CategoryForumPage. Mirrors the realtime + RLS pattern already used by
-- forumposts.

create table if not exists public.forum_replies (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.forumposts (id) on delete cascade,
  author_id uuid not null references auth.users (id) on delete cascade,
  content text not null check (char_length(trim(content)) > 0),
  created_at timestamptz not null default now()
);

create index if not exists forum_replies_post_id_idx
  on public.forum_replies (post_id, created_at);

alter table public.forum_replies enable row level security;

-- Anyone can read replies (matches the public "visible" forum feed).
create policy "Replies are readable by everyone"
  on public.forum_replies
  for select
  using (true);

-- Only signed-in users can add a reply, and only as themselves.
create policy "Authenticated users can add their own replies"
  on public.forum_replies
  for insert
  to authenticated
  with check (auth.uid() = author_id);

-- Enable realtime so CategoryForumPage's .stream() picks up new replies.
alter publication supabase_realtime add table public.forum_replies;
