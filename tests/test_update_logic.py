"""Unit tests for update/version helper logic."""

import dashboard


def test_version_compare_semver_ordering():
    """Semantic tuple comparison should correctly rank newer versions."""
    assert dashboard._is_newer_version("0.12.3", "0.12.2")
    assert dashboard._is_newer_version("v1.0.0", "0.99.9")
    assert not dashboard._is_newer_version("0.12.2", "0.12.2")
    assert not dashboard._is_newer_version("0.12.1", "0.12.2")


def test_version_compare_safe_fallback_for_malformed():
    """Malformed release labels should never incorrectly claim an update."""
    assert not dashboard._is_newer_version("main", "0.12.2")
    assert not dashboard._is_newer_version("release-candidate", "0.12.2")


def test_build_update_state_from_release_payload():
    """Release payload mapping should populate expected schema fields."""
    state = dashboard._build_update_state_from_release({
        "tag_name": "v9.9.9",
        "html_url": "https://github.com/plgonzalezrx8/clawtelemetry/releases/tag/v9.9.9",
        "tarball_url": "https://api.github.com/repos/plgonzalezrx8/clawtelemetry/tarball/v9.9.9",
    })
    assert state["latest_tag"] == "v9.9.9"
    assert state["latest_version"] == "9.9.9"
    assert state["release_url"].startswith("https://github.com/")
    assert state["archive_url"].startswith("https://")
    assert state["update_available"] is True
    assert state["checked_at"]


def test_public_update_state_has_required_keys():
    """Public API shape should remain stable for web clients."""
    public_state = dashboard._public_update_state()
    required = {
        "current_version",
        "latest_version",
        "latest_tag",
        "update_available",
        "checked_at",
        "release_url",
        "last_error",
    }
    assert required.issubset(set(public_state.keys()))
