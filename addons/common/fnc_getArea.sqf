/* ----------------------------------------------------------------------------
Function: CBA_fnc_getArea

DEPRECATED - Please use <BIS_fnc_getArea at https://community.bistudio.com/wiki/BIS_fnc_getArea> added in Arma 3 1.58

Description:
    Returns the array form of any area construct: [center, a, b, angle, isRectangle]

Parameters:
    _area      - The area construct to process <MARKER, TRIGGER, LOCATION, ARRAY>

Returns:
    Area <ARRAY> (Empty array if invalid area was provided)

Examples:
   (begin example)
       _area = [marker] call CBA_fnc_getArea;

       _area = [trigger] call CBA_fnc_getArea;

       _area = [location] call CBA_fnc_getArea;

       _area = [[center, a, b, angle, isRectangle]] call CBA_fnc_getArea;
   (end)

Author:
    SilentSpike
---------------------------------------------------------------------------- */

params [ ["_zRef", [], ["",objNull,locationNull,[]], 5] ];

private _area = [];
if (_zRef isEqualType "") then {
    // Validate that marker exists and is correct shape
    if ((markerShape _zRef) in ["RECTANGLE","ELLIPSE"]) then {
        _area pushBack (markerPos _zRef);
        _area append (markerSize _zRef);
        _area pushBack (markerDir _zRef);
        _area pushBack ((markerShape _zRef) == "RECTANGLE");
    };
} else {
    if (_zRef isEqualType objNull) then {
        // Validate that object is a trigger
        if ((triggerArea _zRef) isNotEqualTo []) then {
            _area pushBack (getPos _zRef);
            _area append (triggerArea _zRef);
            _area resize 5;
        };
    } else {
        if (_zRef isEqualType locationNull) then {
            _area pushBack (getPos _zRef);
            _area append (size _zRef);
            _area pushBack (direction _zRef);
            _area pushBack (rectangular _zRef);
        } else {
            // Validate that area is of correct form
            if (_zRef isEqualTypeArray [[],0,0,0,true]) then {
                _area = _zRef;
            };
        };
    };
};

_area
