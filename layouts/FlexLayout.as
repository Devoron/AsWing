package org.aswing.layouts
{
	import org.aswing.Container;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;

    public class FlexLayout extends EmptyLayout
    {
        private var fixed:Vector.<Boolean>;
        private var fixed_count:int;
        private var gap:int;
        private var maxSize:Vector.<IntDimension>;
        private var minSize:Vector.<IntDimension>;
        private var orientation:int;
        private var pSize:Vector.<IntDimension>;
        private var visibleComponents:int;
        public static const HORIZONTAL:int = 0;
        public static const VERTICAL:int = 1;

        public function FlexLayout(orientation:int = 1, gap:int = 0)
        {
            this.gap = gap;
            this.orientation = orientation;
            return;
        }

        public function getGap() : int
        {
            return this.gap;
        }

        override public function getLayoutAlignmentX(target:Container) : Number
        {
            return 0.5;
        }

        override public function getLayoutAlignmentY(target:Container) : Number
        {
            return 0.5;
        }

        public function getOrientation() : int
        {
            return this.orientation;
        }

        override public function layoutContainer(target:Container) : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_2:* = target.getInsets();
            var _loc_3:* = target.getComponentCount();
            if (_loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = this.preferredLayoutSize(target);
            if (this.visibleComponents == 0)
            {
                return;
            }
            var _loc_7:* = target.getWidth() - (_loc_2.left + _loc_2.right);
            var _loc_8:* = target.getHeight() - (_loc_2.top + _loc_2.bottom);
            if (this.orientation == VERTICAL)
            {
                _loc_5 = _loc_8 - _loc_4.height;
            }
            else
            {
                _loc_5 = _loc_7 - _loc_4.width;
            }
            var _loc_11:* = 0;
            do
            {
                
                _loc_11 = this.fixed_count;
                this.fixed_count = 0;
                _loc_9 = 0;
                while (_loc_9 < this.visibleComponents)
                {
                    
                    _loc_12 = this.pSize[_loc_9];
                    _loc_6 = _loc_5 / (this.visibleComponents - _loc_11);
                    if (this.orientation == VERTICAL)
                    {
                        _loc_13 = _loc_12.height;
                        if (!this.fixed[_loc_9])
                        {
                            _loc_13 = _loc_6 + _loc_12.height;
                        }
                        if (_loc_13 > this.maxSize[_loc_9].height)
                        {
                            var _loc_19:* = this;
                            var _loc_20:* = this.fixed_count + 1;
                            _loc_19.fixed_count = _loc_20;
                            this.fixed[_loc_9] = true;
                            _loc_5 = _loc_5 - (this.maxSize[_loc_9].height - _loc_12.height);
                            _loc_12.height = this.maxSize[_loc_9].height;
                        }
                        else if (_loc_13 < this.minSize[_loc_9].height)
                        {
                            var _loc_19:* = this;
                            var _loc_20:* = this.fixed_count + 1;
                            _loc_19.fixed_count = _loc_20;
                            this.fixed[_loc_9] = true;
                            _loc_5 = _loc_5 - (this.minSize[_loc_9].height - _loc_12.height);
                            _loc_12.height = this.minSize[_loc_9].height;
                        }
                    }
                    else
                    {
                        _loc_13 = _loc_12.width;
                        if (!this.fixed[_loc_9])
                        {
                            _loc_13 = _loc_6 + _loc_12.width;
                        }
                        if (_loc_13 > this.maxSize[_loc_9].width)
                        {
                            var _loc_19:* = this;
                            var _loc_20:* = this.fixed_count + 1;
                            _loc_19.fixed_count = _loc_20;
                            this.fixed[_loc_9] = true;
                            _loc_5 = _loc_5 - (this.maxSize[_loc_9].width - _loc_12.width);
                            _loc_12.width = this.maxSize[_loc_9].width;
                        }
                        else if (_loc_13 < this.minSize[_loc_9].width)
                        {
                            var _loc_19:* = this;
                            var _loc_20:* = this.fixed_count + 1;
                            _loc_19.fixed_count = _loc_20;
                            this.fixed[_loc_9] = true;
                            _loc_5 = _loc_5 - (this.minSize[_loc_9].width - _loc_12.width);
                            _loc_12.width = this.minSize[_loc_9].width;
                        }
                    }
                    _loc_9 = _loc_9 + 1;
                }
                if (this.fixed_count <= 0)
                {
                }
            }while (_loc_11 > 0)
            this.fixed_count = 0;
            _loc_9 = 0;
            while (_loc_9 < this.visibleComponents)
            {
                
                this.fixed_count = this.fixed_count + (this.fixed[_loc_9] == true ? (1) : (0));
                _loc_9 = _loc_9 + 1;
            }
            _loc_6 = _loc_5 / (this.visibleComponents - this.fixed_count);
            var _loc_15:* = _loc_2.left;
            var _loc_16:* = _loc_2.top;
            _loc_14 = 0;
            if (this.orientation == VERTICAL)
            {
                _loc_9 = 0;
                while (_loc_9 < _loc_3)
                {
                    
                    _loc_10 = target.getComponent(_loc_9);
                    if (_loc_10.isVisible())
                    {
                        _loc_17 = this.pSize[_loc_14].height;
                        if (!this.fixed[_loc_14])
                        {
                            _loc_17 = Math.max(0, _loc_6 + _loc_17);
                        }
                        _loc_10.setBounds(new IntRectangle(_loc_15, _loc_16, _loc_7, _loc_17));
                        _loc_16 = _loc_16 + (_loc_17 + this.gap);
                        _loc_14 = _loc_14 + 1;
                    }
                    _loc_9 = _loc_9 + 1;
                }
            }
            else
            {
                _loc_9 = 0;
                while (_loc_9 < _loc_3)
                {
                    
                    _loc_10 = target.getComponent(_loc_9);
                    if (_loc_10.isVisible())
                    {
                        _loc_18 = this.pSize[_loc_14].width;
                        if (!this.fixed[_loc_14])
                        {
                            _loc_18 = Math.max(0, _loc_6 + _loc_18);
                        }
                        _loc_10.setBounds(new IntRectangle(_loc_15, _loc_16, _loc_18, _loc_8));
                        _loc_15 = _loc_15 + (_loc_18 + this.gap);
                        _loc_14 = _loc_14 + 1;
                    }
                    _loc_9 = _loc_9 + 1;
                }
            }
            return;
        }

        override public function maximumLayoutSize(target:Container) : IntDimension
        {
            return IntDimension.createBigDimension();
        }

        override public function minimumLayoutSize(target:Container) : IntDimension
        {
            return target.getInsets().getOutsideSize();
        }

        override public function preferredLayoutSize(target:Container) : IntDimension
        {
            var _loc_4:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = target.getInsets();
            var _loc_3:* = target.getComponentCount();
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.visibleComponents = _loc_3;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (!target.getComponent(_loc_4).isVisible())
                {
                    var _loc_11:* = this;
                    var _loc_12:* = this.visibleComponents - 1;
                    _loc_11.visibleComponents = _loc_12;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (this.visibleComponents > 0)
            {
                this.fixed = new Vector.<Boolean>(this.visibleComponents, true);
                this.fixed_count = 0;
                this.pSize = new Vector.<IntDimension>(this.visibleComponents, true);
                this.maxSize = new Vector.<IntDimension>(this.visibleComponents, true);
                this.minSize = new Vector.<IntDimension>(this.visibleComponents, true);
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_10 = target.getComponent(_loc_4);
                    if (_loc_10.isVisible())
                    {
                        this.pSize[_loc_5] = _loc_10.getPreferredSize();
                        this.minSize[_loc_5] = _loc_10.getMinimumSize();
                        this.maxSize[_loc_5] = _loc_10.getMaximumSize();
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                if (this.orientation == VERTICAL)
                {
                    _loc_6 = this.pSize[0].width;
                }
                else
                {
                    _loc_4 = 0;
                    while (_loc_4 < this.visibleComponents)
                    {
                        
                        _loc_6 = _loc_6 + this.pSize[_loc_4].width;
                        _loc_4 = _loc_4 + 1;
                    }
                }
                if (this.orientation == HORIZONTAL)
                {
                    _loc_7 = this.pSize[0].height;
                }
                else
                {
                    _loc_4 = 0;
                    while (_loc_4 < this.visibleComponents)
                    {
                        
                        _loc_7 = _loc_7 + this.pSize[_loc_4].height;
                        _loc_4 = _loc_4 + 1;
                    }
                }
            }
            if (this.orientation == VERTICAL)
            {
                _loc_8 = 0;
                _loc_9 = (this.visibleComponents - 1) * this.gap;
            }
            else
            {
                _loc_9 = 0;
                _loc_8 = (this.visibleComponents - 1) * this.gap;
            }
            return new IntDimension(_loc_6 + _loc_8, _loc_7 + _loc_9);
        }

    }
}
