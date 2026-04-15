DROP TABLE IF EXISTS playback_events;

CREATE TABLE playback_events (
    id BIGSERIAL PRIMARY KEY,

    -- time
    start_time TIMESTAMPTZ,
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
    device_id TEXT,          -- from filename

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

-- indexes for Grafana
CREATE INDEX idx_time ON playback_events (start_time);
CREATE INDEX idx_device_id ON playback_events (device_id);
CREATE INDEX idx_content ON playback_events (content_name);