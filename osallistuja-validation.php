<?php
/**
 * Plugin Name: Osallistuja Validation
 * Description: Server-side validation for the ilmoittautumislomake form.
 * Version: 1.0.0
 * Author: PHZ
 */

defined('ABSPATH') || exit;

add_filter(
    'wpcf7_validate_text',
    'validate_osallistuja_name',
    20,
    2
);

add_filter(
    'wpcf7_validate_text*',
    'validate_osallistuja_name',
    20,
    2
);

function validate_osallistuja_name($result, $tag)
{
    if ('osallistuja' !== $tag->name) {
        return $result;
    }

    $value = isset($_POST['osallistuja'])
        ? sanitize_text_field(wp_unslash($_POST['osallistuja']))
        : '';

    $value = trim($value);

    if (
        $value === '' ||
        preg_match('/^[\p{L} -]+$/u', $value)
    ) {
        $result->invalidate(
            $tag,
            'Osallistujan nimessä saa olla vain kirjaimia.'
        );
    }

    return $result;
}
