-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Drop existing table
DROP TABLE IF EXISTS playback_events;

-- Create table
CREATE TABLE playback_events (
    id BIGSERIAL PRIMARY KEY,

    -- time
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ,
    duration_ms INTEGER,

    -- content
    content_id TEXT,
    content_name TEXT,
    type TEXT,
    subtype TEXT,
    content_provider TEXT,

    -- canvas / program
    canvas_id TEXT,
    canvas_name TEXT,
    program_id TEXT,

    -- device
    mac TEXT,
    device_name TEXT,
    device_id TEXT,

    -- org structure
    workspace_id TEXT,
    workspace_name TEXT,
    org_id TEXT,
    org_name TEXT,

    -- layout
    x INTEGER,
    y INTEGER,
    width INTEGER,
    height INTEGER,

    -- playback meta
    network_status INTEGER,
    pop_version TEXT,
    play_style TEXT,
    content_version TEXT,

    page_index TEXT,
    page_title TEXT,
    pop_type TEXT,
    page_table_index TEXT,

    real_play_ms INTEGER,
    video_preparing_time INTEGER,
    widget_pop TEXT,

    -- meta
    source_file TEXT,
    ingested_at TIMESTAMPTZ DEFAULT now()
);

-- Convert to hypertable
SELECT create_hypertable(
    'playback_events',
    'start_time',
    chunk_time_interval => INTERVAL '1 day',
    if_not_exists => TRUE
);

-- Indexes (optimized for Timescale usage)
CREATE INDEX idx_playback_time ON playback_events (start_time DESC);
CREATE INDEX idx_playback_device_time ON playback_events (device_id, start_time DESC);
CREATE INDEX idx_playback_content_time ON playback_events (content_name, start_time DESC);